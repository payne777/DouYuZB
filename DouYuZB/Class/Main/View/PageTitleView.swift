//
//  PageTitleView.swift
//  DouYuZB
//
//  Created by 王鹏 on 2022/7/30.
//

import UIKit

protocol PageTitleViewDelegate:AnyObject {
    func pageTItleView(titleView:PageTitleView, selectedIndex index:Int)
}

private let KScrollLineH:CGFloat = 2
private let KNormalColor:(CGFloat,CGFloat,CGFloat) = (85,85,85)
private let KSelectColor:(CGFloat,CGFloat,CGFloat) = (255,128,0)

class PageTitleView:UIView {
    // mark 自定义属性
    private var currentIndex:Int = 0
    private var titles:[String]
    weak var delegate: PageTitleViewDelegate?
    private var titleLabels:[UILabel] = [UILabel]()
    
    // 懒加载属性
    private lazy var scrollView:UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    
    private lazy var scrollLine:UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    // 自定义构造函数
    init(frame:CGRect , titles:[String]) {
        self.titles = titles
        super.init(frame: frame)
        // 设置ui页面
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
     
}

extension PageTitleView {
    private func setupUI() {
        // 添加uiscrollview
        addSubview(scrollView)
        scrollView.frame = bounds
        // 添加title对应的label
        setupTitleLabels()
        // 设置底线和滚动的滑块
        setupBottomMenuAndScrollLine()
        
    }
     
    private func setupTitleLabels() {
        // 确定label的frame值
        let labelW:CGFloat = frame.width / CGFloat(titles.count)
        let labelH:CGFloat = frame.height - KScrollLineH
        let labelY:CGFloat = 0
        
        
        for (index,title) in titles.enumerated() {
            let label = UILabel()
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor(r: KNormalColor.0, g: KNormalColor.1, b: KNormalColor.2)
            // 设置label的frame
            let labelX:CGFloat = labelW * CGFloat(index)
            
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            // 将label添加到scrollview中
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            // 给label添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(tapGes:)))
            label.addGestureRecognizer(tapGes)
        }
    }
    
    private func setupBottomMenuAndScrollLine() {
        // 添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH:CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        // 添加scrollLine
        // 获取第一个label
        guard let firstLabel = titleLabels.first else {return}
        firstLabel.textColor = UIColor(r: KSelectColor.0, g: KSelectColor.1, b: KSelectColor.2)
        
        // 设置scroll的属性
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - KScrollLineH, width: firstLabel.frame.width, height: KScrollLineH)
    }
}


// 监听label
extension PageTitleView {
    @objc private func titleLabelClick(tapGes:UITapGestureRecognizer) {
        // 获取当前的label下标
        guard let currentLabel = tapGes.view as? UILabel else { return }
        // 获取之前的label
        let oldLabel = titleLabels[currentIndex]
        // 切换文字颜色
        currentLabel.textColor = UIColor(r: KSelectColor.0, g: KSelectColor.1, b: KSelectColor.2)
        oldLabel.textColor = UIColor(r: KNormalColor.0, g: KNormalColor.1, b: KNormalColor.2)
        
        // 保存最新label下标值
        currentIndex = currentLabel.tag
        
        // 滚动条位置发生改变
        let scrollLineX = CGFloat(currentLabel.tag) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        // 通知代理
        delegate?.pageTItleView(titleView: self, selectedIndex: currentIndex)
    }
}

// 对外暴漏方法
extension PageTitleView {
    func setTitleViewProgress(progress:CGFloat,sourceIndex:Int,targetIndex:Int) {
        // 取出sourceLabel/targetLabel
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        // 处理滑块的逻辑
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
      
        // 颜色渐变
        let colorDelta = (KSelectColor.0 - KNormalColor.0,  KSelectColor.1 - KNormalColor.1, KSelectColor.2 - KNormalColor.2)
        sourceLabel.textColor = UIColor(r: KSelectColor.0 - colorDelta.0 * progress, g: KSelectColor.1 - colorDelta.1 * progress, b: KSelectColor.2 - colorDelta.2 * progress)
        
        targetLabel.textColor = UIColor(r: KSelectColor.0 + colorDelta.0 * progress, g: KSelectColor.1 + colorDelta.1 * progress, b: KSelectColor.2 + colorDelta.2 * progress)
    }
}


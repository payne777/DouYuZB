//
//  PageContentView.swift
//  DouYuZB
//
//  Created by 王鹏 on 2022/7/30.
//

import UIKit

protocol PageContentViewDelegate:AnyObject {
    func PageContentView(contentView:PageContentView,progress:CGFloat,sourceIndex:Int,targetIndex:Int)
}

private let ContentCellID = "ContentCellID"
class PageContentView:UIView {
     
    private var childVcs:[UIViewController]
    private var parentViewController:UIViewController?
    private var startOffsetX:CGFloat = 0
    private var isForbidScrollDelegate:Bool = false
    weak var delegate:PageContentViewDelegate?
    
    // 懒加载属性
    private lazy var collectionView:UICollectionView = { [weak self] in
       // 创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        // 创建uiconllectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = false
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        return collectionView
    }()
    
    // 自定义构造函数
    init(frame:CGRect,childVcs:[UIViewController],parentViewController:UIViewController?) {
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        super.init(frame: frame)
        // 设置UI
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
}

// mark设置ui界面
extension PageContentView {
    private func setupUI() {
        // 将所有的字控制器添加到父控制器
        for childVc in childVcs {
            parentViewController?.addChild(childVc)
        }
        // 添加uicollectionview，用于在cell中存放控制器的view
        addSubview(collectionView)
        collectionView.frame = bounds
        
    }
}

// 遵守uicollectionview协议
extension PageContentView:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        // 给cell设置内容
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let childVc = childVcs[indexPath.item]
        cell.contentView.addSubview(childVc.view)
        
        return cell
    }
}

extension PageContentView:UICollectionViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("检测scrollview滚动")
        var progress:CGFloat = 0
        var sourceIndex:Int = 0
        var targetIndex:Int = 0
        
        // 判断左滑动还是右滑动
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        
        if currentOffsetX > startOffsetX { //左滑动
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            sourceIndex = Int(currentOffsetX / scrollViewW)
            
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
        } else {
            progress = 1 - CGFloat(currentOffsetX / scrollViewW)
            targetIndex = Int(currentOffsetX / scrollViewW)
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVcs.count {
                sourceIndex = childVcs.count - 1
            }
        }
    }
}

// 对外暴漏的方法
extension PageContentView {
    func setCurrentIndex(currentIndex:Int) {
        // 禁止执行代理方法
        isForbidScrollDelegate = true
        // 拖动位置
        let offSetX = CGFloat(currentIndex) * collectionView.frame.size.width
        collectionView.setContentOffset(CGPoint(x: offSetX, y: 0), animated: false)
    }
}

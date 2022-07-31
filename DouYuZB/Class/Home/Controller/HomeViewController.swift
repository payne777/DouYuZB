//
//  HomeViewController.swift
//  DouYuZB
//
//  Created by 王鹏 on 2022/7/30.
//

import UIKit

private let KTitleViewH:CGFloat = 0
class HomeViewController:UIViewController {
    // 懒加载属性
    private lazy var pageTitleView:PageTitleView = { [weak self] in
        let titleFrame = CGRect(x: 0, y: KStatusBarH + KNavigationBarH, width: KScreenW, height: KTitleViewH )
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.backgroundColor = UIColor.orange;
        titleView.delegate = self
        return titleView
    }()
    
    private lazy var pageContentView:PageContentView = {[weak self] in
        // 确定我们内容的frame
        let contentH = KScreenH - KStatusBarH - KNavigationBarH - KTitleViewH
        let contentFrame = CGRect(x: 0, y: KStatusBarH + KNavigationBarH + KTitleViewH, width: KScreenH, height: contentH)
        // 确定所有的字控制器
        var childVcs = [UIViewController]()
        childVcs.append(RecommendViewController())
        for _ in 0..<3 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
        let contentView = PageContentView.init(frame: contentFrame, childVcs: childVcs, parentViewController: self)
        contentView.delegate = self as? PageContentViewDelegate
        return contentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// mark 设置ui界面
extension HomeViewController {
    private func setupUI() {
        // 不需要调整uiscrollview那边距
        automaticallyAdjustsScrollViewInsets = false
        // 设置导航栏
        setupNaviationBar()
        // 添加titleView
        view.addSubview(pageTitleView)
        // 添加contentView
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.purple
    }
    
    private func setupNaviationBar() {
        let btn = UIButton()
        btn.setImage(UIImage.init(named: ""), for: .normal)
        btn.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
         
        
//        let historyItem = UIBarButtonItem.createItem(itemName: "", highImageName: "", size: CGSize.init(width: 40, height: 40))
//        let searchItem = UIBarButtonItem.createItem(itemName: "", highImageName: "", size: CGSize.init(width: 40, height: 40))
//        let qrcodeItem = UIBarButtonItem.createItem(itemName: "", highImageName: "", size: CGSize.init(width: 40, height: 40))
        
        let historyItem = UIBarButtonItem(itemName: "", highImageName: "", size: CGSize.init(width: 44, height: 44))
        let searchItem = UIBarButtonItem(itemName: "", highImageName: "", size: CGSize.init(width: 44, height: 44))
        let qrcodeItem = UIBarButtonItem(itemName: "", highImageName: "", size: CGSize.init(width: 44, height: 44))
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]
    }
}

// 遵守PageTitleViewDelegate代理协议
extension HomeViewController:PageTitleViewDelegate {
    func pageTItleView(titleView: PageTitleView, selectedIndex index: Int) {
        print(index)
    }
}

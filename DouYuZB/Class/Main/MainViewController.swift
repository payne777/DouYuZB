//
//  MainViewController.swift
//  DouYuZB
//
//  Created by 王鹏 on 2022/7/30.
//

import UIKit
 
class MainViewController:UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addChildVc(storyName: "Home")
        addChildVc(storyName: "Live")
        addChildVc(storyName: "Follow")
        addChildVc(storyName: "Me")
    }
    
    private func addChildVc(storyName: String) {
        let childVc = UIStoryboard.init(name:storyName, bundle: nil).instantiateInitialViewController()!
        addChild(childVc)
    }
}

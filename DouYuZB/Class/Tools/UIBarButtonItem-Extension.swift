//
//  UIBarButtonItem-Extension.swift
//  DouYuZB
//
//  Created by 王鹏 on 2022/7/30.
//

import UIKit

extension UIBarButtonItem {
    
    // 类方法
//    class func createItem(itemName:String,highImageName:String,size:CGSize) -> UIBarButtonItem {
//
//        let size = CGSize.init(width: 44, height: 44)
//        let btn = UIButton()
//        btn.setImage(UIImage.init(named: ""), for: .normal)
//        btn.setImage(UIImage.init(named: ""), for: .highlighted)
//        btn.frame = CGRect(origin: CGPoint.zero, size: size)
//        return UIBarButtonItem(customView: btn)
//    } 
//
    // 遍历构造函数,convenience开头，构造函数中必须明确调用一个设计的构造函数（self）
    convenience init(itemName:String,highImageName:String,size:CGSize) {
        let size = CGSize.init(width: 44, height: 44)
        let btn = UIButton()
        btn.setImage(UIImage.init(named: ""), for: .normal)
        if highImageName != "" {
            btn.setImage(UIImage.init(named: ""), for: .highlighted)
        }
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        self.init(customView: btn)
    }
}

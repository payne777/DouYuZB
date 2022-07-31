//
//  UIColor-Extension.swift
//  DouYuZB
//
//  Created by 王鹏 on 2022/7/30.
//

import UIKit

extension UIColor {
    convenience init(r:CGFloat , g:CGFloat , b:CGFloat) {
        self.init(r: r / 255.0, g: g / 255.0, b: b / 255.0)
    }
}

//
//  NSDate-Extension.swift
//  DouYuZB
//
//  Created by 王鹏 on 2022/8/1.
//

import UIKit

extension NSDate {
    class func getCurrentTime() -> String {
        let nowDate = NSDate()
        let interval = Int(nowDate.timeIntervalSince1970)
        return "\(interval)"
    }
}

//
//  AnchorModel.swift
//  DouYuZB
//
//  Created by 王鹏 on 2022/8/1.
//

import UIKit

class AnchorModel: NSObject {
    var room_id:Int = 0 // 房间号
    var vertical_src:String = ""
    var isVertical:Int = 0
    var room_name:String = ""
    var onLine:Int = 0
     
    init(dict:[String:NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override class func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}

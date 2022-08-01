//
//  AnchorGroup.swift
//  DouYuZB
//
//  Created by 王鹏 on 2022/8/1.
//

import UIKit

class AnchorGroup: NSObject {
    var room_list:[[String:NSObject]]? {
        didSet {
            guard let room_list = room_list else {
                return
            }
            for dict in room_list {
                anchors.append(AnchorModel(dict: dict))
            }
        }
    }
    var tag_name:String = ""
    var icon_name:String = "home_header_normal"
    private lazy var anchors:[AnchorModel] = [AnchorModel]()
    init(dict:[String:NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override class func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    override class func setValue(_ value: Any?, forKey key: String) {
        if key == "room_list" {
            if let dataArray = value as? [[String : NSObject]] {
                for dict in dataArray {
                    anchors.append(AnchorModel(dict: dict))
                }
            }
        }
    }
    
}

//
//  NetworkTools.swift
//  DouYuZB
//
//  Created by 王鹏 on 2022/7/31.
//

import UIKit

enum MethodType {
    case GET
    case POST
}

class NetworkTools {
    class func requestData(type:MethodType,UrlString:String,paramters:[String:NSString]? = nil,finishedCallback:(_ result:AnyObject) -> ()) {
        
//        //将枚举类型的get／post转换成http请求的get／post
//        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
//        //Alamofire请求方法
//        Alamofire.request(URLString, method: method, parameters: parameters).responseJSON { (response) in
//            //打印数据
//            print(response)
//            //校检服务器返回的数据类型是否正确
//            guard let result = response.result.value else { return }
//            //将结果回调出去
//            finishedCallback(result)
//        }
    }
}

//
//  NetTool.swift
//  InKe-Copy
//
//  Created by clearlove on 2017/11/29.
//  Copyright © 2017年 clearlove. All rights reserved.
//

import UIKit
import Alamofire

class NetTool: NSObject {

    static let shared = NetTool()
    
    /// get请求
    ///
    /// - Parameters:
    ///   - url: 地址
    ///   - params: 参数
    ///   - success: 成功回调
    ///   - failture: 失败回调
    func getRequest(url:String,params:[String:Any],success:@escaping(_ response:[String:AnyObject]) -> (),failture:@escaping(_ error:Error) -> ()) {
        Alamofire.request(url, method: .get, parameters: params).responseJSON { (respon) in
            switch respon.result{
            case .success(_):
                if let value = respon.result.value as? [String:AnyObject] {
                    success(value)
                }
            case .failure(let error):
                failture(error)
            }
        }
    }
    
    /// post请求
    ///
    /// - Parameters:
    ///   - url: 地址
    ///   - params: 参数
    ///   - success: 成功回调
    ///   - failture: 失败回调
    func postRequest(url:String,params:[String:Any],success:@escaping(_ response:[String:AnyObject]) -> (),failture:@escaping(_ error:Error) -> ()) {
        Alamofire.request(url, method: .post, parameters: params).responseJSON { (respon) in
            switch respon.result{
            case .success(_):
                if let value = respon.result.value as? [String:AnyObject] {
                    success(value)
                }
            case .failure(let error):
                failture(error)
            }
        }
    }
}

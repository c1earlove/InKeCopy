//
//  Const.swift
//  CRM2.0
//
//  Created by clearlove on 2017/6/20.
//  Copyright © 2017年 clearlove. All rights reserved.
//

import UIKit
import Foundation

//MARK: -- release
let kCrmRelease:Bool = true

//MARK: -- 屏幕宽高相关
let kScreenBounds = UIScreen.main.bounds
let kScreenHeight:CGFloat = kScreenBounds.size.height
let kScreenWidth:CGFloat = kScreenBounds.size.width
let kMainWindow = UIApplication.shared.keyWindow
let kStatuBarHeight:CGFloat = UIApplication.shared.statusBarFrame.size.height
let kTabBarHeight:CGFloat = kStatuBarHeight == 20 ? 49 : 83
let kTopHeight:CGFloat = 44 + kStatuBarHeight

//MARK: --颜色相关
let kNavColor = UIColor(red: 0, green: 0.85, blue: 0.79, alpha: 1)

func kRGBA(_ r:CGFloat,_ g:CGFloat,_ b:CGFloat,_ a:CGFloat) -> UIColor{
    return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
}


// MARK:- 自定义打印方法
func CRMLog<T>(_ message : T, file : String = #file, funcName : String = #function, lineNum : Int = #line) {

    let fileName = (file as NSString).lastPathComponent
    let date = NSDate()
    let timeFormatter = DateFormatter()
    timeFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
    let strNowTime = timeFormatter.string(from: date as Date) as String
    
    print("🐓🐷❤️❤️❤️❤️❤️🐷🐓\(strNowTime)--\(fileName):(\(lineNum))-\(funcName):\(message)")

}

// MARK: -- 接口

/** 附近页接口*/
let kNearAPI = "http://116.211.167.106/api/live/near_flow_old?&gender=1&gps_info=116.449411%2C39.904484&loc_info=CN%2C%E5%8C%97%E4%BA%AC%E5%B8%82%2C%E5%8C%97%E4%BA%AC%E5%B8%82&is_new_user=1&lc=0000000000000049&cc=TG0001&cv=IK4.0.00_Iphone&proto=7&idfa=2D707AF8-980F-415C-B443-6FED3E9BBE97&idfv=723152C7-9C98-43F8-947F-18331280D72F&devi=135ede19e251cd6512eb6ad4f418fbbde03c9266&osversion=ios_10.100000&ua=iPhone5_2&imei=&imsi=&uid=392716022&sid=20f7ZyQ3C09I3wDcU0i0bM5n3F8osSAui2L04fGf4WTHRgL9J8qi1&conn=wifi&mtid=87edd7144bd658132ae544d7c9a0eba8&mtxid=acbc329027f3&logid=133&interest=0&longitude=116.449411&latitude=39.904484&multiaddr=1&s_sg=dba9d2e16943a8d4568e8bc0f32e6f7d&s_sc=100&s_st=1488507776"

// MARK: -- UserDefault
let KUserDefauls = UserDefaults.standard
// 是否登录
let kLogin = "login"

// MARK: -- 第三方登陆相关的key
/// 新浪微博key
let kSinaWBKey = "3828130245"
/// 新浪微博secret
let kSinaWBSecret = "42754d70a94f38ec219d451bfcc099d2"
/// 新浪微博授权回调
let kSinaWBredirectUri = "http://www.baidu.com"
/// 微信APPID
let kWeChatAppId = ""
/// 微信APPSecret
let kWeChatAppSecret = ""
/// QQAPPID
let kQqAppId = "1106543165"
/// QQAPPKey
let kQqAppKey = "D1NWpmCT59EGmpUn"


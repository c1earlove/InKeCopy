//
//  ShareModule.swift
//  InKe-Copy
//
//  Created by clearlove on 2017/12/21.
//  Copyright © 2017年 clearlove. All rights reserved.
//

import UIKit

class ShareModule: NSObject {

    
    class func setupShareSDK() {
        ShareSDK.registerActivePlatforms(
            [
                SSDKPlatformType.typeQQ.rawValue,
                SSDKPlatformType.typeWechat.rawValue,
                SSDKPlatformType.typeSinaWeibo.rawValue
            ],
            onImport: { (platformType:SSDKPlatformType) in
                switch platformType {
                case .typeSinaWeibo:
                    ShareSDKConnector.connectWeibo(WeiboSDK.classForCoder())
                case .typeWechat:
                    ShareSDKConnector.connectWeChat(WXApi.classForCoder())
                case .typeQQ:
                    ShareSDKConnector.connectQQ(QQApiInterface.classForCoder(), tencentOAuthClass: TencentOAuth.classForCoder())
                default:
                    break
                }
        }, onConfiguration: { (type, appInfo) in
            switch type {
                
            case .typeSinaWeibo:
                // 设置新浪微博应用信息，其中authType设置为使用SSO+Web形式授权
                appInfo?.ssdkSetupSinaWeibo(byAppKey: kSinaWBKey, appSecret: kSinaWBSecret, redirectUri: kSinaWBredirectUri, authType: SSDKAuthTypeBoth)
                
            case .typeWechat:
                // 微信的应用信息
                appInfo?.ssdkSetupWeChat(byAppId: "", appSecret: "")
            case .typeQQ:
                // 设置qq应用信息
                appInfo?.ssdkSetupQQ(byAppId: kQqAppId, appKey:kQqAppKey , authType: SSDKAuthTypeBoth)
                break
            default:
                break
                
            }
        })
    }

}

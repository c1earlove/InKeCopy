//
//  AppDelegate.swift
//  InKe-Copy
//
//  Created by clearlove on 2017/11/29.
//  Copyright © 2017年 clearlove. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        let baseTab = BaseTabBarViewController()
        let root = LoginViewController()
        // MARK: -- 设置分享
        ShareModule.setupShareSDK()

        if launchOptions != nil {
            if KUserDefauls.bool(forKey: kLogin) { // 已经登陆过
                self.window?.rootViewController = baseTab
            } else {
                self.window?.rootViewController = root
            }
        }else{
            if KUserDefauls.bool(forKey: kLogin) { // 已经登陆过
                addADVC(rootVC: baseTab)
            } else {
                addADVC(rootVC: root)
            }
        }
        self.window?.makeKeyAndVisible()
        self.window?.backgroundColor = .white
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


extension AppDelegate {
    private func addADVC(rootVC:UIViewController)  {
        let adVC = ZLaunchAdVC(waitTime: 4, rootVC: rootVC)
        adVC.configure({ (buttonConfig, adViewConfig) in
            buttonConfig.skipBtnType = .textLeftTimerRight
            adViewConfig.animationType = .slideFromLeft
            adViewConfig.adFrame = (window?.bounds)!
        })
        adVC.setImage("http://chatm-icon.oss-cn-beijing.aliyuncs.com/pic/pic_20171109145155437.gif", duration: 10, options: .readCache, action: {
            let vc = ADViewController()
            vc.adUrl = "http://www.baidu.com"
            vc.view.backgroundColor = UIColor.yellow
            if rootVC.childViewControllers.count > 0 {
                vc.transFlag = "push"
                let homeVC = rootVC.childViewControllers[0].childViewControllers[0] as! HomeViewController
                homeVC.navigationController?.pushViewController(vc, animated: true)
            }else{
                vc.transFlag = "present"
                rootVC.present(vc, animated: true, completion: {
                })
            }
        })
        self.window?.rootViewController = adVC
    }
}


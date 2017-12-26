//
//  LoginViewController.swift
//  InKe-Copy
//
//  Created by clearlove on 2017/12/13.
//  Copyright © 2017年 clearlove. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    /// 背景图片
   private lazy var backgroundImageView:UIImageView = {
        let imgv = UIImageView(frame: kScreenBounds)
        imgv.image = UIImage(named: "login_bg_wallpaper")
        return imgv
    }()
    /// 小鸟图片
   private lazy var littleBirdImageView:UIImageView = {
       let imgv = UIImageView(image: UIImage(named: "login_tree"))
        imgv.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 110)
        imgv.centerY = view.centerY
        return imgv
    }()
    
   private lazy var loginView:CustomerLoginButtonView = {
        let log = CustomerLoginButtonView(frame: CGRect(x: 0, y: kScreenHeight - 150 - 20, width: kScreenWidth - 40, height: 150))
        log.centerX = view.centerX
        return log
    }()
    /// 大云彩
    private lazy var bigCloud:UIImageView = {
        let im = UIImageView(image: UIImage(named: "login_bg_cloud_1"))
        im.sizeToFit()
        return im
   }()
    /// 中等云彩
    private lazy var midCloud:UIImageView = {
        let im = UIImageView(image: UIImage(named: "login_bg_cloud_2"))
        im.sizeToFit()
        return im
    }()
    /// 小云彩
    private lazy var smallerCloud:UIImageView = {
        let im = UIImageView(image: UIImage(named: "login_bg_cloud_2"))
        im.sizeToFit()
        return im
    }()
    
    let postionKey = "position"
    let bigKey = "bigCloudMove"
    let midKey = "midCloudMove"
    let smallKey = "smallCloudMove"
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(backgroundImageView)
        view.addSubview(littleBirdImageView)
        view.addSubview(loginView)
        loginView.loginButtonClickHandler = { (tag) in
            CRMLog(tag)
//            KUserDefauls.setValue(true, forKey: kLogin)
//            self.goHomeVC()
            self.thirdLogin(tag: tag)
        }
//        littleBirdImageView.snp.makeConstraints { (make) in
//            make.centerY.centerX.width.equalTo(view)
//            make.height.equalTo(110)
//        }
        /// 添加大云彩
        bigCloud.x = kScreenWidth 
        bigCloud.y = 100
        view.addSubview(bigCloud)
        bigCloud.layer.add(startAnimationWithDuration(20, point: CGPoint(x:0 - bigCloud.width, y: bigCloud.y)), forKey: bigKey)
        
       
        /// 添加中等云彩
        view.insertSubview(midCloud, belowSubview: littleBirdImageView)
        midCloud.x = bigCloud.x
        midCloud.y = bigCloud.maxY + 80
        midCloud.layer.add(startAnimationWithDuration(13, point: CGPoint(x: 0 - midCloud.width, y: midCloud.y)), forKey: midKey)
        /// 添加小云彩
        view.insertSubview(smallerCloud, belowSubview: littleBirdImageView)
        smallerCloud.x = bigCloud.x
        smallerCloud.y = littleBirdImageView.maxY + 5
        smallerCloud.layer.add(startAnimationWithDuration(8, point: CGPoint(x: 0 - smallerCloud.width, y: smallerCloud.y)), forKey: smallKey)
        
        CRMLog(bigCloud.frame)
        CRMLog(midCloud.frame)
        CRMLog(smallerCloud.frame)
    }

    private func startAnimationWithDuration(_ duration:CFTimeInterval,point:CGPoint) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: postionKey)
        animation.toValue = NSValue(cgPoint: point)
        animation.duration = duration
        animation.repeatCount = MAXFLOAT
        animation.isRemovedOnCompletion = false
        return animation
    }
    /// 到主页
    func goHomeVC() {
        let root = BaseTabBarViewController()
        let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.window?.rootViewController = root
        
        
    }
    private func removeAnimation() {
        bigCloud.layer.removeAnimation(forKey: bigKey)
        midCloud.layer.removeAnimation(forKey: midKey)
        smallerCloud.layer.removeAnimation(forKey: smallKey)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: -- 第三方登陆操作
    func thirdLogin(tag:Int) {
        
        if tag == 10 {// Sina
            ShareSDK.getUserInfo(.typeSinaWeibo, onStateChanged: { (state, user, error) in
                CRMLog(state)
                CRMLog(user?.uid)
                CRMLog(user?.credential)
                CRMLog(user?.credential.token)
                CRMLog(user?.nickname)
                self.goHomeVC()
            })
        }else if (tag == 11) { // WeChat
            
        }else if (tag == 12) { // SMS
            SMSSDK.getVerificationCode(by: .SMS, phoneNumber: "15238366140", zone: "86", template: "123456", result: { (error) in
                
            })
        }else if (tag == 13) { // QQ
            ShareSDK.getUserInfo(.typeQQ) { (state:SSDKResponseState?, user:SSDKUser?, error:Error?) in
                
                CRMLog(user?.uid)
                CRMLog(user?.credential)
                CRMLog(user?.credential.token)
                CRMLog(user?.nickname)
                self.goHomeVC()
            }
        }
       
    }
    deinit {
        removeAnimation()
    }
}

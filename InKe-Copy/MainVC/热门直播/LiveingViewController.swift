//
//  LiveingViewController.swift
//  InKe-Copy
//
//  Created by clearlove on 2017/12/4.
//  Copyright © 2017年 clearlove. All rights reserved.
//

import UIKit

class LiveingViewController: UIViewController {
    
    /// 直播流
    var liveingUrl = ""
    
    /// 头像地址
    var portraitUrl = ""
    
    /// ijk播放器
    var IJKPlayer:IJKMediaPlayback!
    
    /// 视频容器
    var playerView:UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundImageView()
        setPlayerView()
        buttons()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !self.IJKPlayer.isPlaying() {
            IJKPlayer.prepareToPlay()
        }
    }
    
    
    /// 设置背景图片 + 模糊处理 iOS 8自带模糊处理
    func setBackgroundImageView() {
        let backImageView = UIImageView(frame: kScreenBounds)
        self.view.addSubview(backImageView)
        backImageView.kf.setImage(with: URL(string: portraitUrl), placeholder: UIImage(named: ""))
        
        let blureffect = UIBlurEffect(style: .light)
        let effectView = UIVisualEffectView(effect: blureffect)
        effectView.frame = backImageView.bounds
        backImageView.addSubview(effectView)
    }

    /// 设置容器和播放器
    func setPlayerView() {
        playerView = UIView(frame: view.bounds)
        view.addSubview(playerView)
        
        //初始化播放器的控制器的View
        IJKPlayer = IJKFFMoviePlayerController(contentURLString: "http://120.92.224.235:8080/live/694.flv", with: nil)
        let v = IJKPlayer.view!
        
        // 将播放器的View自适应加入容器
        v.frame = playerView.bounds
        v.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        playerView.insertSubview(v, at: 1)
        IJKPlayer.scalingMode = .aspectFill
    }
    func buttons() {
        let backButton = UIButton(type: .custom)
        backButton.setBackgroundImage(UIImage(named: "goback"), for: .normal)
        backButton.frame = CGRect(x: 10, y: 30, width: 40, height: 40)
        playerView.addSubview(backButton)
        backButton.addTarget(self, action: #selector(backCLick), for: .touchUpInside)
        
        let giftButton = UIButton(type: .custom)
        giftButton.setBackgroundImage(#imageLiteral(resourceName: "gift"), for: .normal)
        giftButton.frame = CGRect(x: 10, y: kScreenHeight - 30 - 40, width: 40, height: 40)
        playerView.addSubview(giftButton)
        giftButton.addTarget(self, action: #selector(giftButtonClick(_ :)), for: .touchUpInside)
        
        let likeButton = UIButton(type: .custom)
        likeButton.setBackgroundImage(#imageLiteral(resourceName: "like"), for: .normal)
        likeButton.frame = CGRect(x: kScreenWidth - 10 - 40, y: kScreenHeight - 30 - 40, width: 40, height: 40)
        playerView.addSubview(likeButton)
        likeButton.addTarget(self, action: #selector(likeButtonClick(_ :)), for: .touchUpInside)
    }
    
    @objc func backCLick() {
        
        IJKPlayer.shutdown()
        self.navigationController?.popViewController(animated: true)
    }
    @objc func giftButtonClick(_ button:UIButton) {
        let duration = 3.0
        let p918 = UIImageView(image: UIImage(named: "porsche"))
        p918.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        view.addSubview(p918)
        let width:CGFloat = 240
        let height:CGFloat = 120
        UIView.animate(withDuration: duration) {
            p918.frame = CGRect(x: self.view.centerX - width / 2, y: self.view.centerY - height / 2, width: width, height: height)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            UIView.animate(withDuration: duration, animations: {
                p918.alpha = 0
            }, completion: { (_) in
                p918.removeFromSuperview()
            })
        }
        
        
        
    }
    @objc func likeButtonClick(_ button:UIButton) {
        
        /// 爱心大小
        let heartView = DMHeartFlyView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        heartView.center = CGPoint(x: button.x, y: button.y)
        view.addSubview(heartView)
        heartView.animate(in: view)
        //爱心按钮的 大小变化动画
        let btnAnime = CAKeyframeAnimation(keyPath: "transform.scale")
        btnAnime.values   = [1.0, 0.7, 0.5, 0.3, 0.5, 0.7, 1.0, 1.2, 1.4, 1.2, 1.0]
        btnAnime.keyTimes = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0]
        btnAnime.duration = 0.2
        button.layer.add(btnAnime, forKey: "SHOW")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

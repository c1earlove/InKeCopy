//
//  CameraView.swift
//  InKe-Copy
//
//  Created by clearlove on 2017/11/29.
//  Copyright © 2017年 clearlove. All rights reserved.
//

import UIKit
import SnapKit
import Then


typealias buttonClickColures = (_ tag:Int) -> ()
class CameraView: UIView {

    var block:buttonClickColures?
    
    /// 直播按钮
    let liveButton : UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: kScreenHeight, width: kScreenWidth / 2, height: kScreenWidth / 2)
        button.backgroundColor = .clear
        button.setImage(UIImage(named: "shortvideo_main_live"), for: .normal)
        button.tag = 10001
        button.setTitle("直播", for: .normal)
        button.setTitleColor(UIColor.gray, for: .normal)
        button.layoutButtonWithEdgeInsetsStyle(style: ButtonEdgeInsetsStyle.ButtonEdgeInsetsStyleTop, imageTitleSpace: 5)
        button.addTarget(self, action: #selector(buttonClick(button:)), for: .touchUpInside)
        // 关键帧 damp阻尼
        UIView.animate(withDuration: 0.8, delay: 0.1, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .allowUserInteraction, animations: {
            button.frame = CGRect(x: 0, y: kScreenHeight - 50 - kScreenWidth / 2, width: kScreenWidth / 2, height: kScreenWidth / 2)
        }, completion: { (_) in
            
        })
        return button
    }()
    
    /// 短视频按钮
    let videoButton : UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: kScreenWidth / 2, y: kScreenHeight, width: kScreenWidth / 2, height: kScreenWidth / 2)
        button.backgroundColor = .clear
        button.setImage(UIImage(named: "shortvideo_main_video"), for: .normal)
        button.tag = 10002
        button.setTitle("短视频", for: .normal)
        button.setTitleColor(UIColor.gray, for: .normal)
        button.layoutButtonWithEdgeInsetsStyle(style: ButtonEdgeInsetsStyle.ButtonEdgeInsetsStyleTop, imageTitleSpace: 5)
        button.addTarget(self, action: #selector(buttonClick(button:)), for: .touchUpInside)
        // 关键帧 damp阻尼
        UIView.animate(withDuration: 0.8, delay: 0.1, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .allowUserInteraction, animations: {
            button.frame = CGRect(x: kScreenWidth / 2, y: kScreenHeight - 50 - kScreenWidth / 2, width: kScreenWidth / 2, height: kScreenWidth / 2)
        }, completion: { (_) in
            
        })
        return button
    }()
    
    // 关闭按钮
    lazy var closeButton:UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: kScreenHeight - 50, width: kScreenWidth, height: 50)
        button.backgroundColor = .white
        button.setImage(UIImage(named: "shortvideo_launch_close"), for: .normal)
        
        button.addTarget(self, action: #selector(closeClick), for: .touchUpInside)
        return button
    }()

    lazy var backView : UIView = {
        let view = UIView(frame: CGRect(x: 0, y: kScreenHeight - 50 - kScreenWidth / 2, width: kScreenWidth, height: kScreenWidth / 2))
        view.backgroundColor = UIColor.white
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = kRGBA(0, 0, 0, 0.3)
        createUI()
    }
    func createUI() {
        self.addSubview(backView)
        self.addSubview(liveButton)
        self.addSubview(videoButton)
        self.addSubview(closeButton)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //弹出视图
    func popShow() {
        kMainWindow?.addSubview(self)
    }
    // 关闭视图
    @objc func closeClick() {
        self.removeFromSuperview()
    }
    
    // 点击上方灰色区域移除视图
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let allTouches:Set = (event?.allTouches)!
        let touch:UITouch = allTouches.first!
        let point:CGPoint = touch.location(in: self)
        
        if point.y < kScreenHeight - 50 - kScreenWidth / 2 {
            self.removeFromSuperview()
        }
        
    }

    @objc func buttonClick(button:UIButton) {
        block!(button.tag)
    }
    
}

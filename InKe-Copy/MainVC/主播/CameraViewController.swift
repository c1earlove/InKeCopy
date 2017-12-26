//
//  CameraViewController.swift
//  InKe-Copy
//
//  Created by clearlove on 2017/11/29.
//  Copyright © 2017年 clearlove. All rights reserved.
//

import UIKit
import LFLiveKit

class CameraViewController: UIViewController {

    /// LFLiveSession
    lazy var liveSession:LFLiveSession = {
        let session = LFLiveSession(audioConfiguration: LFLiveAudioConfiguration.default(), videoConfiguration: LFLiveVideoConfiguration.defaultConfiguration(for: LFLiveVideoQuality.medium2))
        return session!
    }()
    
    lazy var livingPreView:UIView = {
       let v = UIView(frame: kScreenBounds)
        v.backgroundColor = .clear
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.insertSubview(livingPreView, at: 0)
        liveSession.delegate = self
        liveSession.running = true
        liveSession.preView = livingPreView
        // 默认前置摄像头
        liveSession.captureDevicePosition = .front
        createUI()
    }
    // 设置开始开始直播、美颜、切换摄像头、返回按钮
    
    /// 直播按钮
    var startButton:UIButton!
    
    /// 美颜按钮
    var beautyFaceButton:UIButton!
    
    /// 切换摄像头按钮
    var transCameraButton:UIButton!
    
    /// 返回按钮
    var backButton:UIButton!
    
    func createUI() {
        startButton = UIButton(type: .custom)
        startButton.setTitle("开始直播", for: .normal)
        startButton.setTitle("关闭直播", for: .selected)
        self.view.addSubview(startButton)
        startButton.clipsToBounds = true
        startButton.layer.borderColor = kNavColor.cgColor
        startButton.layer.borderWidth = 0.5
        startButton.layer.cornerRadius = 20
        startButton.snp.makeConstraints { (make) in
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.bottom.equalTo(-50)
            make.height.equalTo(40)
        }
        startButton.addTarget(self, action: #selector(liveButtonClick(_:)), for: .touchUpInside)
        // 美颜按钮
        beautyFaceButton = UIButton(type: .custom)
        self.view.addSubview(beautyFaceButton)
        beautyFaceButton.setTitle(" 智能美颜已开启 ", for: .normal)
        beautyFaceButton.setTitle(" 关闭美颜 ", for: .normal)
        beautyFaceButton.clipsToBounds = true
        beautyFaceButton.layer.cornerRadius = 5
        beautyFaceButton.layer.borderWidth = 0.5
        beautyFaceButton.layer.borderColor = kNavColor.cgColor
        beautyFaceButton.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(kStatuBarHeight + 10)
            make.height.equalTo(20)
        }
        beautyFaceButton.addTarget(self, action: #selector(beautyButtonClick(_:)), for: .touchUpInside)
       // 返回按钮
        backButton = UIButton(type: .custom)
        backButton.clipsToBounds = true
        backButton.layer.cornerRadius = 20
        backButton.setImage(UIImage(named: "liveClose"), for: .normal)
        self.view.addSubview(backButton)
        backButton.snp.makeConstraints { (make) in
            make.right.equalTo(-20)
            make.centerY.equalTo(beautyFaceButton)
            make.width.height.equalTo(40)
        }
        backButton.addTarget(self, action: #selector(liveCloseButtonClick(_:)), for: .touchUpInside)
        
        // 切换前后摄像头按钮
        transCameraButton = UIButton(type: .custom)
        transCameraButton.clipsToBounds = true
        transCameraButton.layer.cornerRadius = 20
        transCameraButton.setImage(UIImage(named: "camera_change"), for: .normal)
        self.view.addSubview(transCameraButton)
        transCameraButton.snp.makeConstraints { (make) in
            make.right.equalTo(backButton.snp.left).offset(-10)
            make.centerY.equalTo(beautyFaceButton)
            make.width.height.equalTo(40)
        }
        transCameraButton.addTarget(self, action: #selector(transCameraButtonClick(_:)), for: .touchUpInside)
        
    }
    /// 切换摄像头按钮
    @objc func transCameraButtonClick(_ button:UIButton) {
        button.isSelected = !button.isSelected
        if button.isSelected {
            self.liveSession.captureDevicePosition = .back
        }else{
            self.liveSession.captureDevicePosition = .front
        }
    }
    /// 返回按钮点击
    @objc func liveCloseButtonClick(_ button:UIButton) {
        if  self.liveSession.state == .pending || self.liveSession.state == .start {
            self.liveSession.stopLive()
        }
        self.dismiss(animated: true, completion: nil)
    }
    /// 美颜按钮点击
   @objc func beautyButtonClick(_ button:UIButton) {
        button.isSelected = !button.isSelected
        self.liveSession.beautyFace = !self.liveSession.beautyFace
    }
    
    /// 直播按钮点击
   @objc func liveButtonClick(_ button:UIButton) {
        button.isSelected = !button.isSelected
        if button.isSelected { // 开始直播
            beginLive()
        }else{ // 关闭直播
         
            self.liveSession.stopLive()
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func beginLive() {
        let stream = LFLiveStreamInfo()
        let uuidStr:NSString = UIDevice.current.identifierForVendor?.uuidString as! NSString
        let devCode = uuidStr.substring(to: 3)
        let streamSrv = "rtmp://120.92.224.235/live"
        let streamUrl = streamSrv + devCode
        stream.url = streamUrl
        liveSession.startLive(stream)
    }
    
}
// MARK: -- LFLiveSessionDelegate
extension CameraViewController : LFLiveSessionDelegate {
    func liveSession(_ session: LFLiveSession?, liveStateDidChange state: LFLiveState) {
        switch (state) {
        case .ready:
            CRMLog("准备中")
            break;
        case .pending:
            CRMLog("连接中")
            
            break;
        case .start:
            CRMLog("已连接")
            break;
        case .stop:
            CRMLog("已断开")
            break;
        case .error:
            CRMLog("连接出错")
            break;
        case .refresh:
            CRMLog("刷新")
            break;
       
         
        default:
            break;
        }
    }
    
    func liveSession(_ session: LFLiveSession?, debugInfo: LFLiveDebug?) {
        
    }
    
    func liveSession(_ session: LFLiveSession?, errorCode: LFLiveSocketErrorCode) {
        
    }
}

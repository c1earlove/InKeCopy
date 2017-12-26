//
//  BaseTabBarViewController.swift
//  InKe-Copy
//
//  Created by clearlove on 2017/11/29.
//  Copyright © 2017年 clearlove. All rights reserved.
//

import UIKit

class BaseTabBarViewController: UITabBarController,UINavigationControllerDelegate,UIImagePickerControllerDelegate{
    
    var imagePickerController:UIImagePickerController!
    
    lazy var backView:UIView = {
        let v = UIView(frame: kScreenBounds)
        v.backgroundColor = .white
        return v
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.insertSubview(backView, at: 0)
        self.tabBar.isOpaque = true
        self.tabBar.tintColor = .black
        // 隐藏tabbar上的线
        let t = UITabBar.appearance()
        t.shadowImage = UIImage()
        t.backgroundImage = UIImage()
        
        initChildViewControllers()
    }

    private func initChildViewControllers() {
        // 首页
        let homeVC = HomeViewController()
        let homeNav = BaseNavViewController(rootViewController: homeVC)
        addChildViewController(nav: homeNav, normalImageName: "tab_live", selectedImageName: "tab_live_p")
        
        // 个人
        let personVC = PersonViewController()
        let personNav = BaseNavViewController(rootViewController: personVC)
        
        addChildViewController(nav: personNav, normalImageName: "tab_me", selectedImageName: "tab_me_p")
        
        let tabbar = TabBar()
        tabbar.myDelegate = self
        self.setValue(tabbar, forKey: "tabBar")
    }
    
    private func addChildViewController(nav:UIViewController,normalImageName:String,selectedImageName:String) {
        let childVC = nav.childViewControllers.first
        //tabBarItem图片，显示原图 否则变形
        let normalImage = UIImage(named: normalImageName)?.withRenderingMode(.alwaysOriginal)
        let selectedImage = UIImage(named: selectedImageName)?.withRenderingMode(.alwaysOriginal)
        childVC?.tabBarItem.image = normalImage
        childVC?.tabBarItem.selectedImage = selectedImage
        self.addChildViewController(nav)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension BaseTabBarViewController:TbaBarDelegate {
    func cameraButtonClick(tabBarView: TabBar) {
        let popCameraView = CameraView(frame: kScreenBounds)

        popCameraView.block = { tag in
            CRMLog(tag)
            popCameraView.closeClick()
            if tag == 10001 { //直播按钮
                self.setupLiveConfig()
            }else if tag == 10002 { // 短视频按钮
                self.setupVideoConfig()
            }
            
        }
        popCameraView.popShow()
    }
    // 直播
    func setupLiveConfig() {
        let cameraVC = CameraViewController()
        self.present(cameraVC, animated: true, completion: nil)
    }
    
    // 短视频
    func setupVideoConfig() {
        let sourceType:UIImagePickerControllerSourceType = .camera
        imagePickerController = UIImagePickerController()
        imagePickerController.allowsEditing = false
        imagePickerController.delegate = self
        setupImagePicker(type: sourceType)
        
        self.modalPresentationStyle = .overCurrentContext
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    func setupImagePicker(type:UIImagePickerControllerSourceType) {
        if type != .camera {
            return
        }
        imagePickerController.sourceType = type
        UIApplication.shared.isStatusBarHidden = true
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let index = self.tabBar.items?.index(of: item)
        animatedWithindex(index: index!)
    }
    
    func animatedWithindex(index:Int) {
        // 不知为何,无法设置数组类型为UITabBarButton??????所以设置成了Any
        var tabArr = Array<Any>()
        for tabbarButton in self.tabBar.subviews {
            if tabbarButton.isKind(of: NSClassFromString("UITabBarButton")!) {
                tabArr.append(tabbarButton)
            }
        }
        let base:CABasicAnimation = CABasicAnimation(keyPath: "transform.scale")
        base.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        base.duration = 0.1
        base.repeatCount = 1
        base.autoreverses = true
        base.fromValue = 0.8
        base.toValue = 1.2
        // 给tabBarButton添加动画效果
        let tabBarLayer = (tabArr[index] as AnyObject).layer
        tabBarLayer?.add(base, forKey: "Base")
    }
}








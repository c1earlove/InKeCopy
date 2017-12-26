//
//  TabBar.swift
//  InKe-Copy
//
//  Created by clearlove on 2017/11/29.
//  Copyright © 2017年 clearlove. All rights reserved.
//

import UIKit

protocol TbaBarDelegate : UITabBarDelegate {
    
    /// 点击相机视频按钮 中间的按钮
    ///
    /// - Parameter tabBarView: tabbar
    func cameraButtonClick(tabBarView : TabBar)
}

class TabBar: UITabBar {
    
//    var delegate:TabBarDelegate? 这样写会报错 在objective - c中重写继承的属性是可能的，但在Swift中是不可能的。我处理这个的方法是将一个单独的委托声明为正确类型的计算属性，并设置实际的委托:

    var myDelegate: TbaBarDelegate? {
        get {
            return self.delegate as? TbaBarDelegate
        }
        set {
            self.delegate = newValue
        }
    }
    
    // 按钮
    fileprivate lazy var camerButton:UIButton = {
        let button = UIButton(type: .custom)
        button.setBackgroundImage(UIImage(named: "tab_launch"), for: .normal)
        button.size = (button.currentBackgroundImage?.size)!
        button.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addSubview(camerButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        camerButton.centerY = self.height * 0.125
        let tabBarItemWidth:CGFloat = self.width / 3
        camerButton.centerX = self.centerX
        var tabBarItemIndex = 0
        for childItem:UIView in self.subviews {
            if childItem.isKind(of: NSClassFromString("UITabBarButton")!) {
                childItem.width = tabBarItemWidth
                childItem.x = CGFloat(tabBarItemIndex) * tabBarItemWidth
                tabBarItemIndex += 1
                if tabBarItemIndex == 1 {
                    tabBarItemIndex += 1
                }
            }
        }
        
        
    }
    // 按钮点击事件
    @objc func buttonClick() {
        self.myDelegate?.cameraButtonClick(tabBarView: self)
    }
    
}


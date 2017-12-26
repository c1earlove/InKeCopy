//
//  UIScrollViewExtension.swift
//  InKe-Copy
//
//  Created by clearlove on 2017/12/12.
//  Copyright © 2017年 clearlove. All rights reserved.
//

import UIKit

extension UIScrollView {
    
    private struct key{
        static let headViewKey = UnsafeRawPointer(bitPattern: "headKye".hashValue)
        static let keyFlag = "head"
    }
    
    // 参考简书 Swift3.0朝圣之路-使用Runtime在分类Extension中添加属性 http://www.jianshu.com/p/53abf1703905
    var topView:UIView? {
        set{
            self.willChangeValue(forKey: key.keyFlag)
            objc_setAssociatedObject(self, key.headViewKey!, newValue, .OBJC_ASSOCIATION_ASSIGN)
            self.didChangeValue(forKey: key.keyFlag)
        }
        get{
            return objc_getAssociatedObject(self, key.headViewKey!) as? UIView
        }
    }
    
    func addSpringHeadView(_ view:UIView) {
        self.contentInset = UIEdgeInsets(top: view.height, left: 0, bottom: 0, right: 0)
        self.addSubview(view)
        view.frame = CGRect(x: 0, y: -view.height, width: view.width, height: view.height)
        topView = view
        self.addObserver(self, forKeyPath: "contentOffset", options: .new, context: nil)
    }
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        self.scrollViewDidScroll(self)
    }
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offY = scrollView.contentOffset.y
        if offY < 0 {
            topView?.frame = CGRect(x: 0, y: offY, width: (topView?.width)!, height: -offY)
        }
    }
}

//
//  UIButtonExtension.swift
//  InKe-Copy
//
//  Created by clearlove on 2017/11/29.
//  Copyright © 2017年 clearlove. All rights reserved.
//

import UIKit

enum ButtonEdgeInsetsStyle {
    /// image 在上 title在下
    case ButtonEdgeInsetsStyleTop
    /// image 在左 title在右
    case ButtonEdgeInsetsStyleLeft
    /// image 在下 title在上
    case ButtonEdgeInsetsStyleBottom
    /// image 在右 title在左
    case ButtonEdgeInsetsStyleRight
}

extension UIButton {

    /// 设置button的titleLabel和imageView的布局样式，及间距
    ///
    /// - Parameters:
    ///   - style: titleLabel和imageView的布局样式
    ///   - imageTitleSpace: titleLabel和imageView的间距
    /**
     *  前置知识点：titleEdgeInsets是title相对于其上下左右的inset，跟tableView的contentInset是类似的，
     *  如果只有title，那它上下左右都是相对于button的，image也是一样；
     *  如果同时有image和label，那这时候image的上左下是相对于button，右边是相对于label的；title的上右下是相对于button，左边是相对于image的。
     */
    func layoutButtonWithEdgeInsetsStyle(style:ButtonEdgeInsetsStyle,imageTitleSpace:CGFloat) {
        // 得到imageView和titleLabel的宽、高
        let imageViewWidth:CGFloat = (self.imageView?.frame.size.width)!
        let imageViewHeight:CGFloat = (self.imageView?.frame.size.height)!
        
        var labelWidth:CGFloat = 0
        var labelHeight:CGFloat = 0
        
        
        if #available(iOS 8, *) { // iOS 8 中 titleLabel的size为0 用下面的方式设置
            labelWidth = (self.titleLabel?.intrinsicContentSize.width)!
            labelHeight = (self.titleLabel?.intrinsicContentSize.height)!
            
        }else{
            labelHeight = (self.titleLabel?.frame.size.height)!
            labelWidth = (self.titleLabel?.frame.size.width)!
        }
        
        // 声明imageEdgeInsets和labelEdgeInsets
        var imageEdgeInsets = UIEdgeInsets.zero
        var labelEdgeInsets = UIEdgeInsets.zero
        
        // 根据style和space得到imageEdgeInsets和labelEdgeInsets的值
        switch style {
        case .ButtonEdgeInsetsStyleTop:
            imageEdgeInsets = UIEdgeInsets(top: -labelHeight - imageTitleSpace / 2, left: 0, bottom: 0, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageViewWidth, bottom: -imageViewHeight - imageTitleSpace / 2, right: 0)
            break
        case .ButtonEdgeInsetsStyleBottom:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -labelHeight - imageTitleSpace / 2, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets(top: -imageViewHeight - imageTitleSpace / 2, left: -imageViewWidth, bottom: 0, right: 0)
            break
        case .ButtonEdgeInsetsStyleLeft:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -imageTitleSpace / 2, bottom: 0, right: imageTitleSpace / 2)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: imageTitleSpace / 2, bottom: 0, right: imageTitleSpace / 2)
        case .ButtonEdgeInsetsStyleRight:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: labelWidth + imageTitleSpace / 2, bottom: 0, right: -labelWidth - imageTitleSpace / 2)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageViewWidth - imageTitleSpace / 2, bottom: 0, right: imageViewWidth + imageTitleSpace / 2)
            break
        }
        
        // 赋值
        self.titleEdgeInsets = labelEdgeInsets
        self.imageEdgeInsets = imageEdgeInsets
        
    }
    
    func button(title:String,textColor:UIColor,textFont:UIFont,tag:Int,frame:CGRect) -> UIButton {
        let button = UIButton(type: .custom)
        button.frame = frame
        button.tag = tag
        button.setTitle(title, for: .normal)
        button.setTitleColor(textColor, for: .normal)
        button.titleLabel?.font = textFont
        return button
    }
    
}






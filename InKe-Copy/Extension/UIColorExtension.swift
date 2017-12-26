//
//  UIColorExtension.swift
//  InKe-Copy
//
//  Created by clearlove on 2017/12/12.
//  Copyright © 2017年 clearlove. All rights reserved.
//

import UIKit

/// 常用颜色枚举
public enum CommonColor {
    case white
    case black
    case blue
    case yellow
    case green
    case cyan
    case red
    case orange
    case purple
    case brown
    case magenta
    case gray
    case lightGray
    case darkGray
    case clear
}

public extension CommonColor {
    var color: UIColor {
        switch self {
        case .white:
            return UIColor.white
        case .black:
            return UIColor.black
        case .green:
            return UIColor.green
        case .red:
            return UIColor.red
        case .blue:
            return UIColor.blue
        case .orange:
            return UIColor.orange
        case .yellow:
            return UIColor.yellow
        case .cyan:
            return UIColor.cyan
        case .purple:
            return UIColor.purple
        case .brown:
            return UIColor.brown
        case .gray:
            return UIColor.gray
        case .magenta:
            return UIColor.magenta
        case .lightGray:
            return UIColor.lightGray
        case .darkGray:
            return UIColor.darkGray
        case .clear:
            return UIColor.clear
        }
    }
}

public extension UIColor {
    class func rgba(r: CGFloat, g: CGFloat, b: CGFloat, a:CGFloat) -> UIColor {
        return UIColor.init(red: r / 255, green: g / 255, blue: b / 255, alpha: a)
    }
    class func randomColor() -> UIColor {
        let red = CGFloat(arc4random_uniform(255))
        let green = CGFloat( arc4random_uniform(255))
        let blue = CGFloat(arc4random_uniform(255))
        let alpha = CGFloat(arc4random_uniform(11))
        return UIColor.rgba(r: red, g: green, b: blue, a: alpha)
    }
    /// 16进制颜色
    class func hexColor(_ color: String, alpha: CGFloat = 1) -> UIColor {
        var cString = color.trimmingCharacters(in: .whitespacesAndNewlines).uppercased() as NSString
        let len = cString.length
        if len < 6 {
            return UIColor.white
        }
        if cString.hasPrefix("#") {
            cString = cString.substring(from: 1) as NSString
        }
        if cString.length != 6 {
            return UIColor.white
        }
        var range: NSRange = NSRange(location: 0, length: 2)
        
        let rString = cString.substring(with: range)
        
        range.location = 2;
        let gString = cString.substring(with: range)
        
        range.location = 4;
        let bString = cString.substring(with: range)
        
        var r:CUnsignedInt = 0
        var g:CUnsignedInt = 0
        var b:CUnsignedInt = 0
        
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor.rgba(r: CGFloat(r), g: CGFloat(g), b: CGFloat(b), a: alpha)
    }
    
    /// 父视图半透明 子视图不透明
    class func color(withFatherAlpha alpha:CGFloat,color:UIColor) -> UIColor{
        return color.withAlphaComponent(alpha)
    }
}

//
//  UIViewExtension.swift
//  InKe-Copy
//
//  Created by clearlove on 2017/11/29.
//  Copyright © 2017年 clearlove. All rights reserved.
//

import UIKit

extension UIView {

    public var size: CGSize {
        get {
            return frame.size
        }
        set {
            frame.size = newValue
        }
    }
    public var origin: CGPoint {
        get {
            return frame.origin
        }
        set {
            frame.origin = newValue
        }
    }
    public var x: CGFloat {
        get {
            return origin.x
        }
        set {
            origin.x = newValue
        }
    }
    public var y: CGFloat {
        get {
            return origin.y
        }
        set {
            origin.y = newValue
        }
    }
    public var width: CGFloat {
        get {
            return size.width
        }
        set {
            size.width = newValue
        }
    }
    public var height: CGFloat {
        get {
            return size.height
        }
        set {
            size.height = newValue
        }
    }
    public var centerX: CGFloat {
        get {
            return center.x
        }
        set {
            center.x = newValue
        }
    }
    public var centerY: CGFloat {
        get {
            return center.y
        }
        set {
            center.y = newValue
        }
    }
    public var maxX: CGFloat {
        return x + width
    }
    public var maxY: CGFloat {
        return y + height
    }


}

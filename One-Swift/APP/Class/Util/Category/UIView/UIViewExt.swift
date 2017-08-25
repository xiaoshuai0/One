//
//  UIViewExt.swift
//  Ge
//
//  Created by 赵帅 on 2017/5/12.
//  Copyright © 2017年 zhaoshuai. All rights reserved.
//

import UIKit

extension UIView  {
    
    func x() -> CGFloat {
        return self.frame.origin.x
    }
    
    func left() -> CGFloat {
        return self.x()
    }
    
    func right() -> CGFloat {
        return self.frame.origin.x + self.frame.size.width
    }
    
    func y() -> CGFloat {
        return self.frame.origin.y
    }
    
    func top() -> CGFloat {
        return self.y()
    }
    
    func bottom() -> CGFloat {
        return self.frame.origin.y + self.frame.size.height
    }
    
    func width() -> CGFloat {
        return self.frame.size.width
    }
    
    func height() -> CGFloat {
        return self.frame.size.height
    }
    
    func setX(_ x: CGFloat) {
        var rect:CGRect = self.frame
        rect.origin.x = x
        self.frame = rect
    }
    
    func setLeft(_ x: CGFloat) {
        self.setX(x)
    }
    
    func setRight(_ right: CGFloat) {
        var rect:CGRect = self.frame
        rect.origin.x = right - rect.size.width
        self.frame = rect
    }
    
    func setY(_ y: CGFloat) {
        var rect:CGRect = self.frame
        rect.origin.y = y
        self.frame = rect
    }
    
    func setTop(_ y: CGFloat) {
        self.setY(y)
    }
    
    func setBottom(_ bottom: CGFloat) {
        var rect:CGRect = self.frame
        rect.origin.y = bottom - rect.size.height
        self.frame = rect
    }
    
    func setWidth(_ width: CGFloat) {
        var rect:CGRect = self.frame
        rect.size.width = width
        self.frame = rect
    }
    
    func setHeight(_ height: CGFloat) {
        var rect:CGRect = self.frame
        rect.size.height = height
        self.frame = rect
    }
    var zs_x: CGFloat {
        get {
            return self.frame.origin.x
        }
        set(newvalue) {
            var rect:CGRect = self.frame
            rect.origin.x = newvalue
            self.frame = rect
        }
    }
    var zs_y: CGFloat {
        get {
            return self.frame.origin.y
        }
        set(newvalue) {
            var rect:CGRect = self.frame
            rect.origin.y = newvalue
            self.frame = rect
        }
    }
    var zs_width: CGFloat {
        get {
            return self.frame.width;
        }
        set(newvalue) {
            var rect:CGRect = self.frame
            rect.size.width = newvalue
            self.frame = rect
        }
    }
    var zs_height: CGFloat {
        get {
            return self.frame.height;
        }
        set(newvalue) {
            var rect:CGRect = self.frame
            rect.size.height = newvalue
            self.frame = rect
        }
    }
    var zs_right: CGFloat {
        get {
            return self.zs_x + self.zs_width
        }
        
        set(newValue) {
            var rect:CGRect = self.frame
            rect.origin.x = newValue - self.zs_width
            self.frame = rect
        }
    }
    var zs_bottom: CGFloat {
        get {
            return self.zs_y + self.zs_height
        }
        
        set(newValue) {
            var rect:CGRect = self.frame
            rect.origin.y = newValue - self.zs_height
            self.frame = rect
        }
    }
    var zs_center: CGPoint {
        get {
            return self.center
        }
        
        set(newValue) {
            self.center = newValue
        }
    }
    
    var zs_centerX: CGFloat {
        get {
            return self.center.x
        }
        set(newValue) {
           var point = self.center
            point.x = newValue
            self.center = point
        }
        
    }
    var zs_centerY: CGFloat {
        get {
            return self.center.y
        }
        set(newValue) {
            var point = self.center
            point.y = newValue
            self.center = point
        }
        
    }
    var zs_size: CGSize {
        get {
            return self.frame.size
        }
        
        set(newvalue) {
            var rect:CGRect = self.frame
            rect.size = newvalue
            self.frame = rect
        }
    }
}

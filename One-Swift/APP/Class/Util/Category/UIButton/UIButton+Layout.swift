//
//  UIButton+Layout.swift
//  One-Swift
//
//  Created by 赵帅 on 2017/8/11.
//  Copyright © 2017年 sun5kong. All rights reserved.
//

import UIKit

public enum ButtonContentLayoutStyle: Int {
    case normal  = 0            //内容居中-图左文右
    case centerIamgeRight       //内容居中-图右文左
    case centerImageTop         //内容居中-图上文下
    case centerImageBottom      //内容居中-图下文上
    case leftImageLeft          //内容居左-图左文右
    case leftImageRight         //内容居左-图右文左
    case rightImageLeft         //内容居右-图左文右
    case rightImageRight        //内容居右-图右文左
}

//extension UINavigationBar {
//    private struct AssociatedKeys {
//        static var overlayKey = "overlayKey"
//    }
//    
//    var overlay: UIView? {
//        get {
//            return objc_getAssociatedObject(self, &AssociatedKeys.overlayKey) as? UIView
//        }
//        set {
//            objc_setAssociatedObject(self, &AssociatedKeys.overlayKey, newValue as UIView?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC
//            )
//        }
//    }
//}

extension UIButton {
    
    private struct AssociatedKeys {
        static var buttonContentTypeStyle = "buttonContentTypeStyle"
        static var zs_padding = "zs_padding"
        static var zs_paddingInset = "zs_paddingInset"
    }
    
    public var zs_buttonContentTypeStyle: ButtonContentLayoutStyle {
        get {
            return (objc_getAssociatedObject(self, &AssociatedKeys.buttonContentTypeStyle) as? ButtonContentLayoutStyle) ?? .normal
        }
        
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.buttonContentTypeStyle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
            setupButtonLayout()
        }
    }
    
    
    public var zs_padding: CGFloat {
        get {
            return (objc_getAssociatedObject(self, &AssociatedKeys.zs_padding) as? CGFloat) ?? 15.0
        }
        
        set {
            objc_setAssociatedObject(self,&AssociatedKeys.zs_padding, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
            setupButtonLayout()
        }
    }
    
    public var zs_paddingInset: CGFloat {
        get {
            return (objc_getAssociatedObject(self, &AssociatedKeys.zs_paddingInset) as? CGFloat) ?? 10.0
        }
        
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.zs_paddingInset, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
            setupButtonLayout()
        }
    }
}

extension UIButton {
    fileprivate func setupButtonLayout() {
        
        self.imageView?.contentMode = .scaleAspectFit
        
        let image_w = self.imageView?.frame.size.width ?? 0
        let image_H = self.imageView?.frame.size.height ?? 0
        
        var title_w = self.titleLabel?.frame.size.width ?? 0
        var title_h = self.titleLabel?.frame.size.height ?? 0
        
        let systemVersion: Float = (UIDevice.current.systemVersion as NSString).floatValue
        if systemVersion >= 8.0 {
            title_w = self.titleLabel?.intrinsicContentSize.width ?? 0
            title_h = self.titleLabel?.intrinsicContentSize.height ?? 0
        }
        
        var imageEdge = UIEdgeInsets.zero
        var titleEdge = UIEdgeInsets.zero
        

        
        switch self.zs_buttonContentTypeStyle {
        case .normal:
            titleEdge = UIEdgeInsets(top: 0, left: self.zs_padding, bottom: 0, right: 0)
            imageEdge = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: self.zs_paddingInset)
            self.contentHorizontalAlignment =  .center
        case .centerIamgeRight:
            titleEdge = UIEdgeInsets(top: 0, left: -image_w - self.zs_padding, bottom: 0, right: image_w)
            imageEdge = UIEdgeInsets(top: 0, left: title_w + self.zs_padding, bottom: 0, right: -title_w)
            self.contentHorizontalAlignment =  .center
        case .centerImageTop:
            titleEdge = UIEdgeInsets(top: 0, left: -image_w, bottom: -image_H - self.zs_padding, right: 0)
            imageEdge = UIEdgeInsets(top: -title_h - self.zs_padding, left: 0, bottom: 0, right: -title_w)
            self.contentHorizontalAlignment =  .center
        case .centerImageBottom:
            titleEdge = UIEdgeInsets(top: -image_H - self.zs_padding, left: -image_w, bottom: 0, right: 0)
            imageEdge = UIEdgeInsets(top: 0, left: 0, bottom: -title_h - self.zs_padding, right: -title_w)
            self.contentHorizontalAlignment = .center
        case .leftImageLeft:
            titleEdge = UIEdgeInsets(top: 0, left: self.zs_paddingInset + self.zs_paddingInset , bottom: 0, right: 0)
            imageEdge = UIEdgeInsets(top: 0, left: self.zs_paddingInset, bottom: 0, right: 0)
            self.contentHorizontalAlignment = .left
        case .leftImageRight:
            titleEdge = UIEdgeInsets(top: 0, left: -image_w + self.zs_paddingInset, bottom: 0, right: 0)
            imageEdge = UIEdgeInsets(top: 0, left: title_w + self.zs_padding + self.zs_paddingInset, bottom: 0, right: 0)
            self.contentHorizontalAlignment = .left
        case .rightImageLeft:
            titleEdge = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: self.zs_paddingInset + self.zs_padding)
            imageEdge = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: self.zs_paddingInset)
            self.contentHorizontalAlignment = .right
        case .rightImageRight:
            titleEdge = UIEdgeInsets(top: 0, left: -self.frame.size.width / 2, bottom: 0, right: image_w + self.zs_padding + self.zs_paddingInset)
            imageEdge = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -title_w + self.zs_paddingInset)
            self.contentHorizontalAlignment = .right
        }
        self.imageEdgeInsets = imageEdge
        self.titleEdgeInsets = titleEdge
        self .setNeedsDisplay()
    }
}
































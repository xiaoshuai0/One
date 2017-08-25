//
//  UINavigationBarExtension.swift
//  StoreDemo
//
//  Created by 赵帅 on 2017/7/5.
//  Copyright © 2017年 sun5kong. All rights reserved.
//

import UIKit



extension UINavigationBar {
    
    private struct AssociatedKeys {
        static var overlayKey = "overlayKey"
        static var statusKey = "statusKey"
    }
    
    var overlay: UIView? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.overlayKey) as? UIView
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.overlayKey, newValue as UIView?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    
    var status: UIView? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.statusKey) as? UIView
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.statusKey, newValue as UIView?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
}


extension UINavigationBar {
    
    func zs_setBackgroundColor(backgroundColor: UIColor) {
        if overlay == nil {
            self.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            overlay = UIView.init(frame: CGRect.init(x: 0, y: 0, width: bounds.width, height: bounds.height+20))
            overlay?.isUserInteractionEnabled = false
            overlay?.autoresizingMask = UIViewAutoresizing.flexibleWidth
            subviews.first?.insertSubview(overlay!, at: 0)
        }
        overlay?.backgroundColor = backgroundColor
        
    }
    
    func zs_setNavgationBar(_ hidden: Bool, animation: Bool) {
        
        self.isHidden = hidden
        if status == nil {
            status = UIView(frame: CGRect.init(x: 0, y: 0, width: bounds.width, height: 20))
            status?.backgroundColor = overlay?.backgroundColor
            status?.isHidden = true
            UIApplication.shared.keyWindow?.addSubview(status!)
        }
        if hidden {
            self.status?.isHidden = false
            UIView.animate(withDuration: 0.25, animations: {
                self.overlay?.frame = CGRect(x: 0, y: -64, width: self.bounds.width, height: self.bounds.height + 20)
            }, completion: { (finish) in
                self.hideBottomHairline()
            })
            
        } else {
            UIView.animate(withDuration: 0.25, animations: {
                self.overlay?.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height + 20)
            }, completion: { (finish) in
                self.showBottomHairline()
                self.status?.isHidden = true
                self.status?.removeFromSuperview()
                self.status = nil
            })
        }
        
    }
    
    func zs_setTranslationY(translationY: CGFloat) {
        transform = CGAffineTransform.init(translationX: 0, y: translationY)
    }
    
    
    func zs_setElementsAlpha(alpha: CGFloat) {
        for (_, element) in subviews.enumerated() {
            if element.isKind(of: NSClassFromString("UINavigationItemView") as! UIView.Type) ||
                element.isKind(of: NSClassFromString("UINavigationButton") as! UIButton.Type) ||
                element.isKind(of: NSClassFromString("UINavBarPrompt") as! UIView.Type)
            {
                element.alpha = alpha
            }
            
            if element.isKind(of: NSClassFromString("_UINavigationBarBackIndicatorView") as! UIView.Type) {
                element.alpha = element.alpha == 0 ? 0 : alpha
            }
        }
        
//        items?.forEach({ (item) in
//            if let titleView = item.titleView {
//                titleView.alpha = alpha
//            }
//            for BBItems in [item.leftBarButtonItems, item.rightBarButtonItems] {
//                BBItems?.forEach({ (barButtonItem) in
//                    if let customView = barButtonItem.customView {
//                        customView.alpha = alpha
//                    }
//                })
//            }
//        })
        
        self.changeShadowImageAlpha(alpha)
        overlay?.alpha = alpha
    }
    
    
    func zs_reset() {
        setBackgroundImage(nil, for: UIBarMetrics.default)
        overlay?.removeFromSuperview()
        overlay = nil
    }
}



extension UIToolbar {
    func hideBottomHairline() {
        self.hairlineImageView?.isHidden = true
    }
    func showBottomHairline() {
        self.hairlineImageView?.isHidden = false
    }
}
extension UINavigationBar {
    func hideBottomHairline() {
        self.hairlineImageView?.isHidden = true
    }
    func showBottomHairline() {
        self.hairlineImageView?.isHidden = false
    }
    //self.shadowImage
    func changeShadowImageAlpha(_ alpha: CGFloat) {
        self.hairlineImageView?.alpha = alpha
    }
}

extension UIView {
    fileprivate var hairlineImageView: UIImageView? {
        return hairlineImageView(in: self)
    }
    fileprivate func hairlineImageView(in view: UIView) -> UIImageView? {
        if let imageView = view as? UIImageView, imageView.bounds.height <= 1.0 {
            return imageView
        }
        
        for subview in view.subviews {
            if let imageView = self.hairlineImageView(in: subview) { return imageView }
        }
        
        return nil
    }
}

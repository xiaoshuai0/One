//
//  UIViewCornerExt.swift
//  Ge
//
//  Created by 赵帅 on 2017/5/12.
//  Copyright © 2017年 zhaoshuai. All rights reserved.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get{
            return self.cornerRadius
        }
        
        set{
            self.layer.cornerRadius = newValue;
            self.layer.masksToBounds = newValue > 0;
        }
    }
    @IBInspectable var borderWidth: CGFloat {
        get{
            return self.layer.borderWidth
        }
        
        set{
            self.layer.borderWidth = newValue
        }
        
    }
    
    @IBInspectable var borderColor: UIColor {
        get{
            return UIColor(cgColor: self.layer.borderColor!)
        }
        
        set{
            self.layer.borderColor = newValue.cgColor
        }
        
    }
    
    @IBInspectable var isOnePx: Bool {
        get{
            return self.isOnePx
        }
        
        set{
            if newValue == true {
                let oneScale =  1.0 / UIScreen.main.scale
                self.layer.borderWidth = oneScale * borderWidth
            } else {
                self.layer.borderWidth = borderWidth
            }
        }
        
    }
    
    
    func addCorner(_ cornerRadius: CGFloat, borderWidth: CGFloat = 1, borderColor: UIColor = UIColor.white, isOnePx: Bool = false) {
        
        self.layer.masksToBounds = cornerRadius > 0;
        
        self.layer.cornerRadius = cornerRadius;
        self.layer.borderColor = borderColor.cgColor
        
        if isOnePx == true {
            let oneScale =  1.0 / UIScreen.main.scale
            self.layer.borderWidth = oneScale * borderWidth
        } else {
            self.layer.borderWidth = borderWidth
        }
        
    }
}

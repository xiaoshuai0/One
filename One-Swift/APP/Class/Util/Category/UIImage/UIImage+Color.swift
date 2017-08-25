//
//  UIImage+Color.swift
//  One-Swift
//
//  Created by 赵帅 on 2017/8/13.
//  Copyright © 2017年 sun5kong. All rights reserved.
//

import UIKit

extension UIImage {
    
    
    class func create(_ color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    
    
    
}

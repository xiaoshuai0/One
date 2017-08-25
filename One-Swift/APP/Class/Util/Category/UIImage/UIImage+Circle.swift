//
//  UIImage+Circle.swift
//  One-Swift
//
//  Created by 赵帅 on 2017/8/13.
//  Copyright © 2017年 sun5kong. All rights reserved.
//

import UIKit

extension UIImage {
    
    class func zs_circleImageWithImageName(_ name: String) -> UIImage{
        return UIImage(named: name)!.zs_circleImage()
    }
    
    func zs_circleImage() -> UIImage {
        
        UIGraphicsBeginImageContext(self.size)
        
        let context = UIGraphicsGetCurrentContext()
        
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        context?.addEllipse(in: rect)
        context?.clip()
        self.draw(in: rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        if let result = image {
            return result
        }
        return UIImage()
    }
}

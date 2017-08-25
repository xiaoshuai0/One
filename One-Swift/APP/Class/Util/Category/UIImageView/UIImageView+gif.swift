//
//  UIImageView+gif.swift
//  One-Swift
//
//  Created by 赵帅 on 2017/8/17.
//  Copyright © 2017年 sun5kong. All rights reserved.
//

import UIKit
import ImageIO

extension UIImageView {
    
    public func playGif(_ name: String?) {
    
        guard var name = name else {
            return
        }
        
        if !name.hasSuffix("gif") {
            name = name + ".gif"
        }
        
        guard let path = Bundle.main.path(forResource: name, ofType: nil), let data = NSData(contentsOfFile: path), let imageSource = CGImageSourceCreateWithData(data, nil) else {
            return
        }
        
        var images = [UIImage]()
        var totalDuration: TimeInterval = 0
        for i in 0..<CGImageSourceGetCount(imageSource) {
            guard let cgImage = CGImageSourceCreateImageAtIndex(imageSource, i, nil) else {
                continue
            }
            let image = UIImage(cgImage: cgImage)
            i==0 ? self.image = image : ()
            images.append(image)
            guard  let properties = CGImageSourceCopyPropertiesAtIndex(imageSource, i, nil) as? NSDictionary, let gifDict = properties[kCGImagePropertyGIFDictionary] as? NSDictionary, let frameDuration = gifDict[kCGImagePropertyGIFDelayTime] as? NSNumber else {
                continue
            }
            totalDuration += frameDuration.doubleValue
        }
        
        self.animationImages = images
        self.animationDuration = totalDuration
        self.animationRepeatCount = 0
        self.startAnimating()
    }
    
    
    
    
    
    
}

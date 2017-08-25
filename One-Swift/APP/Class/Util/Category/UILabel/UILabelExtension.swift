//
//  UILabelExtension.swift
//  StoreDemo
//
//  Created by 赵帅 on 2017/7/6.
//  Copyright © 2017年 sun5kong. All rights reserved.
//

import UIKit

extension UILabel {
    class func createLabel(_ frame: CGRect = CGRect.zero,
                           font: UIFont = UIFont.systemFont(ofSize: 14),
                           textColor: UIColor = UIColor.white,
                           textAlignment: NSTextAlignment = .left,
                           text: String = "") -> UILabel{
    
    
        let label = UILabel()
        label.frame = frame
        label.font = font
        label.textColor = textColor
        label.textAlignment = textAlignment
        label.text = text
        return label
    }
}

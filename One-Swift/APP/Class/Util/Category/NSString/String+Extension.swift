//
//  String+Extension.swift
//  One-Swift
//
//  Created by 赵帅 on 2017/8/4.
//  Copyright © 2017年 sun5kong. All rights reserved.
//

import UIKit

extension String {
    
    
    public func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    public var count: Int {
        return self.characters.count
    }
    
    
    public func getSize(attribute: [String: Any]?, font: UIFont, maxSize: CGSize) -> CGSize {
        var attr = attribute
        if attr == nil {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 6
            
            attr = [NSParagraphStyleAttributeName: paragraphStyle, NSFontAttributeName: font]
        }
        let size = (self as NSString).boundingRect(with: maxSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attr, context: nil).size
        return size
    }
}

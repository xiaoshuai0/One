//
//  NSDateFormatter+Extension.swift
//  One-Swift
//
//  Created by 赵帅 on 2017/8/14.
//  Copyright © 2017年 sun5kong. All rights reserved.
//

import UIKit

extension DateFormatter {
//    class func dateFormatter() -> DateFormatter {
//        var dateFormater: DateFormatter? = nil
//        DispatchQueue.once(token: "dateformatter") { 
//            dateFormater = DateFormatter()
//        }
//        return dateFormater!
//    }
    class func dateformatter(_ dateFormat: String) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter
    }
    
    public class func defaultDateFormatter() -> DateFormatter {
        return self.dateformatter("yyyy-MM-dd HH:mm:ss")
    }
    
    public class func defalutChinaDateFormatter() -> DateFormatter {
        return self.dateformatter("yyyy年MM月dd日")
    }
}

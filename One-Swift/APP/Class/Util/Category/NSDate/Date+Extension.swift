//
//  Date+Extension.swift
//  One-Swift
//
//  Created by 赵帅 on 2017/8/23.
//  Copyright © 2017年 sun5kong. All rights reserved.
//

import UIKit

extension Date {
    func dateCompare() -> String {
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let calender = NSCalendar(calendarIdentifier: .gregorian)
        if self.isThisYear() {
            if isToday() {
                let coms = calender?.components([.hour, .minute], from: self, to: Date(), options: .matchFirst)
                if (coms?.hour)! >= 1 {
                    return "\(String(describing: (coms?.hour)!))小时前"
                } else {
                    return "\(String(describing: (coms?.minute)!))分钟前"
                }
            } else if isYesterDay() {
                fmt.dateFormat = "HH:mm:ss"
                return fmt.string(from: self)
            } else {
                fmt.dateFormat = "MM-dd HH:mm:ss"
                return fmt.string(from: self)
            }
        } else {
            return fmt.string(from: self)
        }
    }
    
    func isThisYear() -> Bool{
        let calender = NSCalendar(calendarIdentifier: .gregorian)
        let selfYear = calender?.component(.year, from: self)
        let nowYear = calender?.component(.year, from: Date())
        return selfYear == nowYear
    }
    
    func isToday() -> Bool {
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyyMMdd"
        
        let selfStr = fmt.string(from: self)
        let nowStr = fmt.string(from: Date())
        return selfStr == nowStr
    }
    
    func isYesterDay() -> Bool {
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyyMMdd"
        
        let selfStr = fmt.string(from: self)
        let yesterStr = fmt.string(from: Date(timeIntervalSinceNow: -60 * 60 * 24))
        return selfStr == yesterStr
    }
}



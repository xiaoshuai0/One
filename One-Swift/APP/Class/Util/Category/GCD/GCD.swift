//
//  GCD.swift
//  One-Swift
//
//  Created by 赵帅 on 2017/8/4.
//  Copyright © 2017年 sun5kong. All rights reserved.
//

import UIKit

extension DispatchQueue {
    
    private static var _onceTracker = [String]()
    
    public class func once(token: String, block:() -> Void) {
        objc_sync_enter(self)
        defer {
            objc_sync_enter(self)
        }
        
        if _onceTracker.contains(token) {
            return
        }
        
        _onceTracker.append(token)
        block()
        objc_sync_exit(self)
    }
    
}

//
//  UIViewBlurExt.swift
//  Ge
//
//  Created by 赵帅 on 2017/5/12.
//  Copyright © 2017年 zhaoshuai. All rights reserved.
//

import UIKit


extension UIView {
    public func zs_removeAllSubViews() {
//        //while (self.subviews.count) {
//        [self.subviews.lastObject removeFromSuperview];
//    }
        while self.subviews.count != 0 {
            self.subviews.last?.removeFromSuperview()
        }
    }
}

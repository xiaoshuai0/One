//
//  HUDExt.swift
//  Ge
//
//  Created by 赵帅 on 2017/5/17.
//  Copyright © 2017年 zhaoshuai. All rights reserved.
//

import UIKit
import SVProgressHUD

extension SVProgressHUD {
    static func HUDConfig() {
        SVProgressHUD.setMinimumDismissTimeInterval(1.0)
        SVProgressHUD.setSuccessImage(UIImage.init(named: "success"))
        SVProgressHUD.setErrorImage(UIImage.init(named: "error"))
    }
    
}

extension UIViewController {
    func showLoading(_ message: String) {
        SVProgressHUD.show(withStatus: message)
    }
    
    func showError(_ message:String) {
        SVProgressHUD.show(withStatus: message)
    }
    
    func showSuccess(_ message: String) {
        SVProgressHUD.showSuccess(withStatus: message)
    }
    
    func showMessage(_ message: String) {
        SVProgressHUD.showInfo(withStatus: message)
    }
}

//
//  BaseNavigationController.swift
//  One-Swift
//
//  Created by 赵帅 on 2017/8/4.
//  Copyright © 2017年 sun5kong. All rights reserved.
//

import UIKit
import FDFullscreenPopGesture
import RxCocoa
import RxSwift
import Then

class BaseNavigationController: UINavigationController {

    fileprivate let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fd_fullscreenPopGestureRecognizer.isEnabled = true
    }

    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.childViewControllers.count > 0 {
            let backBtn = UIButton()
            backBtn.theme_setImage(["back_dark", "back_dark"], forState: .normal)
            backBtn.sizeToFit()
            backBtn.rx
                .tap
                .subscribe(onNext: {
                    self.popViewController(animated: true)
                })
                .addDisposableTo(disposeBag)
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: true)
    }
}


//
//  BaseViewController.swift
//  One-Swift
//
//  Created by 赵帅 on 2017/8/4.
//  Copyright © 2017年 sun5kong. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import Then

class BaseViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.zs_setBackgroundColor(backgroundColor: UIColor.white)
        
//        self.automaticallyAdjustsScrollViewInsets = false
    }

    
    
    
    
    public func hideTabBar(tabBarController: UITabBarController) {
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.5)
        for subView in tabBarController.view.subviews {
            if subView.isKind(of: UITabBar.self) {
                subView.frame = CGRect(x: 0, y: kScreenHeight, width: subView.frame.size.width, height: subView.frame.size.height)
            }
        }
        UIView.commitAnimations()
    }
    
    public func showTabBar(tabBarController: UITabBarController) {
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.5)
        for subView in tabBarController.view.subviews {
            if subView.isKind(of: UITabBar.self) {
                subView.frame = CGRect(x: 0, y: kScreenHeight - subView.frame.size.height, width: subView.frame.size.width, height: subView.frame.size.height)
            }
        }
        UIView.commitAnimations()
    }
    

}

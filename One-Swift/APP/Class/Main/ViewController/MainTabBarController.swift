//
//  MainTabBarController.swift
//  One-Swift
//
//  Created by 赵帅 on 2017/8/4.
//  Copyright © 2017年 sun5kong. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
        
        addChildViewController()
    }

    

}

extension MainTabBarController {
    
    
    fileprivate func addChildViewController() {
        
        setupChildViewController(OHomeViewController(), image: "homeUnselectedV4", selectedImage: "homeSelectedV4")
        setupChildViewController(OALLViewController(), image: "allUnselectedV4", selectedImage: "allSelectedV4")
        setupChildViewController(OMeViewController(), image: "meUnselectedV4", selectedImage: "meSelectedV4")
    }
    
    fileprivate func setupChildViewController(_ vc: BaseViewController, image: String, selectedImage: String) {
        let nav = BaseNavigationController(rootViewController: vc)
        nav.tabBarItem.image = UIImage(named: image)?.withRenderingMode(.alwaysOriginal)
        nav.tabBarItem.selectedImage = UIImage(named: selectedImage)?.withRenderingMode(.alwaysOriginal)
        nav.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        self.addChildViewController(nav)
    }
}


//MARK： 点击动画
extension MainTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        tabBarButtonClick(tabBarButton: getTabBarButton())
    }
    
    private func getTabBarButton() -> UIControl {
        var tabBarButtons: [UIControl] = [UIControl]()
        
        for tabBarButton in self.tabBar.subviews {
            if tabBarButton.isKind(of: NSClassFromString("UITabBarButton") as! UIView.Type) {
                tabBarButtons.append(tabBarButton as! UIControl)
            }
        }
        return tabBarButtons[self.selectedIndex]
    }
    
    private func tabBarButtonClick(tabBarButton: UIControl) {
        for imageView in tabBarButton.subviews {
            if imageView.isKind(of: NSClassFromString("UITabBarSwappableImageView") as! UIView.Type) {
                let animation = CAKeyframeAnimation(keyPath: "transform.scale")
                animation.values = [1.0, 1.1, 0.9, 1.1]
                animation.duration = 0.3
                animation.calculationMode = kCAAnimationCubic
                imageView.layer.add(animation, forKey: nil)
            }
        }
    }
}

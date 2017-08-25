//
//  OPushFromBottomAnimation.swift
//  One-Swift
//
//  Created by 赵帅 on 2017/8/13.
//  Copyright © 2017年 sun5kong. All rights reserved.
//

import UIKit

class OPushFromBottomAnimation: NSObject, UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        //获取toController从上下文
        guard let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else {
            return
        }
        //设置toController的frame
        let screenBounds = UIScreen.main.bounds
        let finalFrame = transitionContext.finalFrame(for: toVC)
        toVC.view.frame = CGRect(x: finalFrame.origin.x, y: screenBounds.size.height, width: finalFrame.size.width, height: finalFrame.size.height)
        //添加toViewController的view到containView
        let containerView = transitionContext.containerView
        containerView.addSubview(toVC.view)
        
        //动画
        let duration = self.transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, animations: {
            toVC.view.frame = finalFrame
        }) { (finish) in
            transitionContext.completeTransition(true)
        }
    }
}

class OPopFromBottomAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        //获取toController从上下文
        guard let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) else {
            return
        }
        guard let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else {
            return
        }
        //设置toController的frame
        let finalFrame = CGRect(x: 0, y: kScreenHeight, width: kScreenWidth, height: kScreenHeight)
        //添加toViewController的view到containView
        let containerView = transitionContext.containerView
        containerView.addSubview(toVC.view)
        containerView.bringSubview(toFront: fromVC.view)
        
        //动画
        let duration = self.transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, animations: {
            fromVC.view.frame = finalFrame
        }) { (finish) in
            transitionContext.completeTransition(true)
        }
    }
}

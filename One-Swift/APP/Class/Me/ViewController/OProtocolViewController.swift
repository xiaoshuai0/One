//
//  OProtocolViewController.swift
//  One-Swift
//
//  Created by 赵帅 on 2017/8/13.
//  Copyright © 2017年 sun5kong. All rights reserved.
//
// 协议


import UIKit

class OProtocolViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "用户协议"
        
        let webUrl = URL(string: "http://m.wufazhuce.com/policy?from=ONEApp")!
        let request = URLRequest(url: webUrl)
        
        let webView = UIWebView().then {
            $0.frame = self.view.bounds
            $0.backgroundColor = UIColor.white
            $0.loadRequest(request)
//            $0.loadHTMLString(s, baseURL: nil)
            $0.delegate = self
            $0.scalesPageToFit = true
        }
        self.view.addSubview(webView)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.zs_setElementsAlpha(alpha: 1)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.zs_setElementsAlpha(alpha: 0)
    }

}

extension OProtocolViewController: UIWebViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
    }
}

extension OProtocolViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
}

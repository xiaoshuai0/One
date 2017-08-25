//
//  OArticleViewController.swift
//  One-Swift
//
//  Created by 赵帅 on 2017/8/17.
//  Copyright © 2017年 sun5kong. All rights reserved.
//

import UIKit

class OArticleViewController: BaseViewController {

    var source_id: String?
    fileprivate var ViewModel: OArticleViewModel!
    fileprivate var loadingView: UIImageView!
    fileprivate var lastOffsetY: CGFloat = 0
    fileprivate var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ViewModel = OArticleViewModel(sourceId: source_id!)
        self.title = "专题"

        webView = UIWebView().then {
            $0.backgroundColor = UIColor.white
            $0.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
            $0.scrollView.contentInset = UIEdgeInsets.init(top: -64, left: 0, bottom: 0, right: 0)
            $0.scrollView.scrollIndicatorInsets = UIEdgeInsets(top: -64, left: 0, bottom: 0, right: 0)
            $0.scrollView.showsVerticalScrollIndicator = false
            $0.scrollView.delegate = self
            $0.delegate = self
        }
        self.view.addSubview(webView)
        
        let bottomView = OBottomView(frame: CGRect.init(x: 0, y: kScreenHeight - 44, width: kScreenWidth, height: 44))
        bottomView.shareAction = {
            
        }
        self.view.addSubview(bottomView)
        loadingView = UIImageView().then{
            $0.playGif("loading_book@3x.gif")
            $0.frame.size = CGSize(width: 60, height: 60)
            $0.center = self.view.center
        }
        self.view.addSubview(loadingView)
        
        ViewModel.detailDatas.asObservable().filter{ $0 != nil }.subscribe(onNext: {[weak self] model in
            
            self?.webView.loadHTMLString(model!.html_content, baseURL: nil)
            self?.webView.backgroundColor = UIColor.withHex(hexString: model!.bg_color)
            bottomView.backgroundColor = UIColor.withHex(hexString: model!.bg_color)
        }).addDisposableTo(disposeBag)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.zs_setElementsAlpha(alpha: 1)
        self.navigationController?.navigationBar.zs_setNavgationBar(false, animation: true)
    }
    

}

extension OArticleViewController: UIWebViewDelegate, UIScrollViewDelegate {
    func webViewDidStartLoad(_ webView: UIWebView) {
        self.navigationController?.navigationBar.zs_setElementsAlpha(alpha: 0)
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        loadingView.stopAnimating()
        loadingView.removeFromSuperview()
        
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        kLog(request.url?.absoluteString)
        return true
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        
        if offsetY <= 0 {
            self.navigationController?.navigationBar.zs_setElementsAlpha(alpha: 0)
        } else {
            self.navigationController?.navigationBar.zs_setElementsAlpha(alpha: 1)
        }
        

    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if velocity.y > 0 {
            self.navigationController?.navigationBar.zs_setNavgationBar(true, animation: true)
        } else {
            self.navigationController?.navigationBar.zs_setNavgationBar(false, animation: true)
        }
    }
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        kLog("animation")
    }
    
}




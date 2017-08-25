//
//  OLoginViewController.swift
//  One-Swift
//
//  Created by 赵帅 on 2017/8/11.
//  Copyright © 2017年 sun5kong. All rights reserved.
//

import UIKit

class OLoginViewController: BaseViewController {

    fileprivate var bgImageView: UIImageView!
    fileprivate var closeBtn: UIButton!
    fileprivate var titleLabel: UILabel!
    fileprivate var weXinBtn: UIButton!
    fileprivate var weiBoBtn: UIButton!
    fileprivate var QQBtn: UIButton!
    fileprivate var orLabel: UILabel!
    fileprivate var mobileBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.delegate = self
        self.navigationController?.navigationBar.zs_setElementsAlpha(alpha: 0)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.delegate = nil
    }
    
    

}
//MARK: UI
extension OLoginViewController {
    fileprivate func setupUI() {
        setupTopView()
        setupBgImageView()
        setupLoginView()
        setupBottomView()
    }
    
    fileprivate func setupBgImageView() {
        bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "personalBackgroundImage")
        bgImageView.contentMode = .scaleToFill
        bgImageView.frame = self.view.bounds
        self.view.addSubview(bgImageView)
        
        let colorView = UIView()
        colorView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.35)
        colorView.frame = bgImageView.bounds
        bgImageView.addSubview(colorView)
        
        bgImageViewAnimation()
    }
    
    fileprivate func setupTopView() {
        
        closeBtn = UIButton().then {
            $0.setImage(UIImage(named:"closeIcon"), for: .normal)
            $0.contentEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
            $0.sizeToFit()
            
            $0.rx.tap
                .subscribe(onNext: { [weak self] in
                kLog("关闭")
                self?.pop()
            })
                .disposed(by: disposeBag)
        }
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: closeBtn)
        
        titleLabel = UILabel().then{
            $0.backgroundColor = .clear
            $0.font = FONT14
            $0.textColor = .white
            $0.textAlignment = .center
            $0.text = "登录ONE"
            $0.sizeToFit()
        }
        self.navigationItem.titleView = titleLabel
    }
    
    fileprivate func setupLoginView() {
        
        let loginView = OLoginTypeView()
        loginView.frame = CGRect(x: 0, y: 120, width: kScreenWidth, height: 200)
        loginView.loginAction.asObservable()
            .skip(1)
            .subscribe(onNext: { [weak self]type in
            switch type {
            case .wechat:
                kLog("微信")
            case .weibo:
                kLog("微博")
            case .qq:
                kLog("QQ")
            case .mobile:
                kLog("手机")
            default:
                break
            }
                
            UserDefaults.standard.do {
                $0.set("login", forKey: "login")
            }
            self?.pop()
        }).disposed(by: disposeBag)
        self.view.addSubview(loginView)
    }
    
    fileprivate func setupBottomView() {
        let attrs = [
            NSFontAttributeName: FONT10,
            NSForegroundColorAttributeName: UIColor.white,
            NSUnderlineStyleAttributeName: 1
        ] as [String : Any]
        let buttonStr = NSMutableAttributedString(string: "创建账号即代表同意使用条款和隐私条约", attributes: attrs)
        let button = UIButton().then {
            
            $0.setAttributedTitle(buttonStr, for: .normal)
            $0.titleLabel?.numberOfLines = 2
            $0.titleLabel?.textAlignment = .center
            $0.rx.tap.subscribe(onNext: {
                self.navigationController?.pushViewController(OProtocolViewController(), animated: true)
            }).addDisposableTo(disposeBag)
            
        }
        self.view.addSubview(button)
        
        button.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.centerX)
            make.bottom.equalTo(self.view.snp.bottom).offset(-kMargin * 2)
            make.width.equalTo(95)
            make.height.equalTo(30)
        }
    }
}

//MARK: private method
extension OLoginViewController {
    fileprivate func bgImageViewAnimation() {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.fromValue = 1
        animation.toValue = 1.5
        animation.duration = 20
        animation.repeatCount = HUGE
        animation.autoreverses = true
        animation.isRemovedOnCompletion = false
        bgImageView.layer.add(animation, forKey: nil)
    }
    
    fileprivate func pop() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension OLoginViewController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .pop {
            return OPopFromBottomAnimation()
        } else {
            return nil
        }
    }
}

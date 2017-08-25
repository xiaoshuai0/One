//
//  OLoginTypeView.swift
//  One-Swift
//
//  Created by 赵帅 on 2017/8/13.
//  Copyright © 2017年 sun5kong. All rights reserved.
//

import UIKit
import RxSwift
import Then
import RxCocoa

enum LoginType {
    case none
    case wechat
    case weibo
    case qq
    case mobile
}
class OLoginTypeView: UIView {

    var loginAction = Variable<LoginType>(.none)
    
    private let disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupUI() {
        
        let weXinBtn = UIButton().then {
            $0.setImage(UIImage(named: "wechatLogin"), for: .normal)
            $0.setImage(UIImage(named: "wechatLoginHigh"), for: .highlighted)
            $0.sizeToFit()
            $0.rx.tap
                .map { return LoginType.wechat }
                .bind(to: loginAction)
                .addDisposableTo(disposeBag)
        }
        self.addSubview(weXinBtn)
        
        let weiBoBtn = UIButton().then {
            $0.setImage(UIImage(named: "weiboLogin"), for: .normal)
            $0.setImage(UIImage(named: "weiboLoginHigh"), for: .highlighted)
            $0.sizeToFit()
            $0.rx.tap
                .map { return LoginType.weibo }
                .bind(to: loginAction)
                .addDisposableTo(disposeBag)
        }
        self.addSubview(weiBoBtn)
        
        let QQBtn = UIButton().then {
            $0.setImage(UIImage(named: "qqLogin"), for: .normal)
            $0.setImage(UIImage(named: "qqLoginHigh"), for: .highlighted)
            $0.sizeToFit()
            $0.rx.tap
                .map { return LoginType.qq }
                .bind(to: loginAction)
                .addDisposableTo(disposeBag)
        }
        self.addSubview(QQBtn)
        
        let orLabel = UILabel().then {
            $0.text = "或者"
            $0.textColor = .white
            $0.textAlignment = .center
            $0.font = FONT10
            $0.sizeToFit()
        }
        self.addSubview(orLabel)
        
        let mobileBtn = UIButton().then {
            $0.setImage(UIImage(named: "mobileLogin"), for: .normal)
            $0.setImage(UIImage(named: "mobileLogin"), for: .highlighted)
            $0.sizeToFit()
            $0.rx.tap
                .map { return LoginType.mobile }
                .bind(to: loginAction)
                .addDisposableTo(disposeBag)
        }
        self.addSubview(mobileBtn)
        
        weXinBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(self.snp.top)
        }
        
        weiBoBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(weXinBtn.snp.bottom).offset(kMargin / 2.0)
        }
        
        QQBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(weiBoBtn.snp.bottom).offset(kMargin / 2.0)
        }
        
        orLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(QQBtn.snp.bottom).offset(kMargin / 2.0)
        }
        
        mobileBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(orLabel.snp.bottom).offset(kMargin / 2.0)
        }
    }
}

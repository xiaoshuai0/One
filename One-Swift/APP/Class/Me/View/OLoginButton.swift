//
//  OLoginButton.swift
//  One-Swift
//
//  Created by 赵帅 on 2017/8/11.
//  Copyright © 2017年 sun5kong. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift

class OLoginButton: UIView {

    var loginAction = Variable()
    
    private let bag = DisposeBag()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.backgroundColor = .clear
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        let icon = UIImageView().then {
            $0.image = UIImage(named: "userDefault")
            $0.cornerRadius = 25.0
            $0.borderWidth = 1.0
            $0.borderColor = .white
        }
        self.addSubview(icon)
        
        let titleLabel = UILabel().then {
            $0.text = "点击登录"
            $0.backgroundColor = .clear
            $0.textAlignment = .center
            $0.font = FONT14
            $0.textColor = .white
        }
        self.addSubview(titleLabel)
        
        let button = UIButton(type: .custom)
        button.rx.tap.bind(to: loginAction).disposed(by: bag)
        self.addSubview(button)
        
        icon.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.centerX.equalTo(self.snp.centerX)
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(icon.snp.bottom).offset(kMargin)
            make.left.right.equalTo(self)
            make.height.equalTo(20)
        }
        
        button.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.zero)
        }
    }
}

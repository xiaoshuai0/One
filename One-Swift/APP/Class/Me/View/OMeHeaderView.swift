//
//  OMeHeaderView.swift
//  One-Swift
//
//  Created by 赵帅 on 2017/8/13.
//  Copyright © 2017年 sun5kong. All rights reserved.
//

import UIKit
import RxSwift
import Kingfisher

class OMeHeaderView: UIView {

    fileprivate var imageView: UIImageView!
    var model = Variable(ONoteModel())
    var offY = Variable<CGFloat>(0.0)
    fileprivate let bag = DisposeBag()
    fileprivate var icon: UIImageView!
    fileprivate var noteNameLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        
        imageView = UIImageView().then {
            $0.image = UIImage(named: "personalBackgroundImage")
            $0.frame = frame
            $0.contentMode = .scaleAspectFill
            $0.clipsToBounds = true
        }
        self.addSubview(imageView)
        
        let avatar = UIImageView().then {
            $0.image = UIImage(named: "WechatIMG17.jpeg")?.zs_circleImage()
        }
        self.addSubview(avatar)
        
        let userNameLabel = UILabel().then {
            $0.text = "sun5kong"
            $0.textAlignment = .center
            $0.textColor = .white
            $0.font = FONT14
            $0.sizeToFit()
        }
        self.addSubview(userNameLabel)
        
        let noteView = UIView().then {
            $0.backgroundColor = UIColor.white
        }
        self.addSubview(noteView)
        
        icon = UIImageView().then {
            $0.contentMode = .scaleToFill
        }
        noteView.addSubview(icon)
        
        noteNameLabel = UILabel().then {
            $0.textAlignment = .center
            $0.textColor = kColorFromHexA(999999)
            $0.font = UIFont.systemFont(ofSize: 10, weight: UIFontWeightThin)
        }
        noteView.addSubview(noteNameLabel)
        
        avatar.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(self.snp.top).offset(64)
            make.size.equalTo(CGSize(width: 60, height: 60))
        }
        
        userNameLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(avatar)
            make.top.equalTo(avatar.snp.bottom).offset(kMargin)
        }
        
        noteView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.size.equalTo(CGSize(width: kScreenWidth / 3.0, height: kScreenWidth / 3.0))
            make.bottom.equalTo(self.snp.bottom).offset(-kMargin * 3.0)
        }
        
        icon.snp.makeConstraints { (make) in
            make.bottom.equalTo(noteView.snp.bottom).offset(-15)
            make.top.equalTo(noteView.snp.top).offset(2)
            make.left.equalTo(noteView.snp.left).offset(2)
            make.right.equalTo(noteView.snp.right).offset(-2)
        }
        
        noteNameLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(icon)
            make.top.equalTo(icon.snp.bottom)
            make.bottom.equalTo(noteView.snp.bottom)
        }
        offY.asObservable().subscribe(onNext: {
            print($0)
            self.imageView.zs_y = $0
            self.imageView.zs_height = kScreenHeight * 0.5 - CGFloat.init($0)
        }).disposed(by: bag)
        
        model.asObservable().map{ $0.picture }.filter{ $0 != nil}.subscribe(onNext: { [weak self] in
            self?.icon.kf.setImage(with: $0)
        }).disposed(by: bag)
        
        model.asObservable().map { $0.content }.filter{ $0.characters.count != 0 }.subscribe(onNext: { [weak self] in
            self?.noteNameLabel.text = $0
        }).disposed(by: bag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

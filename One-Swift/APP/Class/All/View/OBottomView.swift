//
//  OBottomView.swift
//  One-Swift
//
//  Created by 赵帅 on 2017/8/17.
//  Copyright © 2017年 sun5kong. All rights reserved.
//

import UIKit
import RxSwift

class OBottomView: UIView {

    typealias ActionBlock = () -> Void
    fileprivate let disposebag = DisposeBag()
    
    fileprivate var inputBtn: UIButton!
    fileprivate var likeBtn: UIButton!
    fileprivate var commentBtn: UIButton!
    fileprivate var shareBtn: UIButton!
    var shareAction: ActionBlock?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupUI() {
        
        self.backgroundColor = UIColor.white
        
        inputBtn = UIButton().then {
            $0.borderColor = UIColor.lightGray
            $0.cornerRadius = 2.0
            $0.borderWidth = 0.5
            $0.setTitle("写一个评论..", for: .normal)
            $0.setTitleColor(kColorFromHexA(999999), for: .normal)
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: UIFontWeightThin)
            $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: -kMargin, bottom: 0, right: 0)
        }
        self.addSubview(inputBtn)
        
        shareBtn = UIButton().then {
            $0.setImage(UIImage(named: "share_dark"), for: .normal)
            $0.sizeToFit()
            $0.rx.tap.subscribe(onNext: {[weak self] _ in
                if let action = self?.shareAction {
                    action()
                }
                
            }).addDisposableTo(disposebag)
        }
        self.addSubview(shareBtn)
        
        commentBtn = UIButton().then {
            $0.setImage(UIImage(named: "comment_gray"), for: .normal)
            $0.sizeToFit()
        }
        self.addSubview(commentBtn)
        
        likeBtn = UIButton().then {
            $0.setImage(UIImage(named: "like_dark"), for: .normal)
            $0.sizeToFit()
        }
        self.addSubview(likeBtn)
        
        
        inputBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(kMargin * 2)
            make.top.equalTo(self.snp.top).offset(kMargin)
            make.bottom.equalTo(self.snp.bottom).offset(-kMargin)
            make.width.equalTo(self.snp.width).dividedBy(3)
        }
        
        shareBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self.snp.right).offset(-kMargin)
            make.centerY.equalTo(self)
        }
        
        commentBtn.snp.makeConstraints { (make) in
            make.right.equalTo(shareBtn.snp.left).offset(-kMargin * 2)
            make.centerY.equalTo(self)
        }
        
        likeBtn.snp.makeConstraints { (make) in
            make.right.equalTo(commentBtn.snp.left).offset(-kMargin * 2)
            make.centerY.equalTo(self)
        }
    }

}

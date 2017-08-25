//
//  OQuestionCollectionViewCell.swift
//  One-Swift
//
//  Created by 赵帅 on 2017/8/16.
//  Copyright © 2017年 sun5kong. All rights reserved.
//

import UIKit

class OQuestionCollectionViewCell: UICollectionViewCell {
    fileprivate var icon: UIImageView!
    fileprivate var titleLabel: UILabel!
    
    var model: OAllCommonModel? {
        didSet {
            icon.kf.setImage(with: model?.cover, placeholder: UIImage(named:"center_diary_placeholder"))
            titleLabel.text = model?.title
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func configUI() {
        icon = UIImageView().then {
            $0.contentMode = .scaleToFill
        }
        self.addSubview(icon)
        
        let bgView = UIView()
        bgView.backgroundColor = kRGBA(0, g: 0, b: 0, a: 0.4)
        self.addSubview(bgView)
        
        titleLabel = UILabel().then {
            $0.textAlignment = .center
            $0.textColor = .white
            $0.font = FONT12
        }
        self.addSubview(titleLabel)
        
        
        icon.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(self)
        }
        
        bgView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(icon)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.height.equalTo(20)
            make.centerY.equalTo(self)
        }
    }
}

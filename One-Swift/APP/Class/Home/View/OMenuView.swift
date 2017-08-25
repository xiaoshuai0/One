//
//  OMenuView.swift
//  One-Swift
//
//  Created by 赵帅 on 2017/8/23.
//  Copyright © 2017年 sun5kong. All rights reserved.
//

import UIKit

class OMenuView: UIView {

    typealias ShowAction = () -> Void
    var changeBtn: UIButton!
    var action: ShowAction?
    var show: Bool = false {
        didSet {
            imageAnimation(show: show)
        }
    }
    
    override init(frame: CGRect) {
        let temp = CGRect(x: 0, y: 0, width: kScreenWidth, height: 44 + kMargin / 2)
        super.init(frame: temp)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate func setupUI() {
        self.backgroundColor = kRGBA(243, g: 243, b: 243, a: 1)
        
        changeBtn = UIButton().then {
            $0.setTitle("一个 VOL. 1782", for: .normal)
            $0.setImage(UIImage(named: "arrow_down"), for: .normal)
            $0.titleLabel?.font = FONT14
            $0.setTitleColor(kColorFromHexA(999999), for: .normal)
            $0.backgroundColor = UIColor.white
            $0.zs_buttonContentTypeStyle = .centerIamgeRight
            $0.addTarget(self, action: #selector(changeAction(_:)), for: .touchUpInside)
        }
        self.addSubview(changeBtn)
        
        changeBtn.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(self)
            make.height.equalTo(44)
        }
    }
    
    @objc fileprivate func changeAction(_ button: UIButton) {
        button.isSelected = !button.isSelected
        
        imageAnimation(show: button.isSelected)
        
        if action != nil {
            action!()
        }
    }
    
    fileprivate func imageAnimation(show: Bool) {
        if show {
            changeBtn.imageView?.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        } else {
            changeBtn.imageView?.transform = CGAffineTransform.identity
        }
    }
}

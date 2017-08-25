//
//  UIButton+Extension.swift
//  StoreDemo
//
//  Created by 赵帅 on 2017/7/18.
//  Copyright © 2017年 sun5kong. All rights reserved.
//

import UIKit

extension UIButton {
    class func createButton(_ image: String?, title: String?, frame: CGRect = .zero, titleColor: UIColor = .white, font: UIFont = .systemFont(ofSize: 14)) -> UIButton {
        let button = UIButton(type: .custom)
        button.frame = frame
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        if let name = image {
            button.setImage(UIImage(named: name), for: .normal)
        }
        button.titleLabel?.font = font
        return button
    }
}

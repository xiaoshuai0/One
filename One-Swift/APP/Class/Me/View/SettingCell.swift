//
//  SettingCell.swift
//  One-Swift
//
//  Created by 赵帅 on 2017/8/15.
//  Copyright © 2017年 sun5kong. All rights reserved.
//

import UIKit

enum CellType {
    case normal
    case switchBtn
    case detail
}
class SettingCell: UITableViewCell {

    var nameLabel: UILabel!
    var detailLabel: UILabel!
    var switchBtn: UISwitch!
    var type: CellType = .normal {
        didSet {
            switch type {
            case .normal:
                self.accessoryType = .disclosureIndicator
                switchBtn.isHidden = true
                detailLabel.isHidden = true
            case .switchBtn:
                self.accessoryType = .none
                switchBtn.isHidden = false
                detailLabel.isHidden = true
            case .detail:
                self.accessoryType = .none
                switchBtn.isHidden = true
                detailLabel.isHidden = false
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        self.selectionStyle = .none
        self.separatorInset = .zero
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupUI() {
        nameLabel = UILabel().then {
            $0.textColor = kColorFromHexA(666666)
            $0.font = UIFont.systemFont(ofSize: 12, weight: UIFontWeightThin)
            $0.textAlignment = .left
            $0.frame = CGRect(x: kMargin, y: self.contentView.zs_centerY - 10, width: kScreenWidth / 3, height: 20)
        }
        self.contentView.addSubview(nameLabel)
        
        detailLabel = UILabel().then {
            $0.textAlignment = .right
            $0.textColor = kColorFromHexA(666666)
            $0.textAlignment = .right
            $0.font = UIFont.systemFont(ofSize: 10, weight: UIFontWeightThin)
            $0.frame = CGRect(x: kScreenWidth - kMargin - kScreenWidth / 3, y: nameLabel.zs_y, width: kScreenWidth / 3, height: 20)
        }
        self.contentView.addSubview(detailLabel)
        
        switchBtn = UISwitch().then {
            $0.sizeToFit()
            $0.frame = CGRect(x: kScreenWidth - kMargin - $0.zs_width, y: self.contentView.zs_centerY - $0.zs_height / 2.0, width: $0.zs_width, height: $0.zs_height)
            $0.onTintColor = kRGBA(131, g:173 , b: 223, a: 1)
        }
        self.addSubview(switchBtn)
    }
    
    
}

//
//  OHotAuthorCell.swift
//  One-Swift
//
//  Created by 赵帅 on 2017/8/16.
//  Copyright © 2017年 sun5kong. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class OHotAuthorCell: UITableViewCell {

    fileprivate var tableView: UITableView!
    fileprivate var changeBtn: UIButton!
    fileprivate let disposeBag = DisposeBag()
    fileprivate var index = 0
    var datas: [OHotAuthor] = []
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
        
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func configUI() {
        self.backgroundColor = kRGBA(243, g: 243, b: 243, a: 1)
        self.contentView.backgroundColor = kRGBA(243, g: 243, b: 243, a: 1)
        self.selectionStyle = .none
        
        let bgView = UIView()
        bgView.backgroundColor = UIColor.white
        self.contentView.addSubview(bgView)
        
        let nameLabel = UILabel().then {
            $0.text = "所有人问所有人"
            $0.textColor = kRGBA(115, g: 115, b: 155, a: 1)
            $0.textAlignment = .left
            $0.font = FONT12
        }
        bgView.addSubview(nameLabel)
        
        tableView = UITableView(frame: .zero, style: .plain).then {
            $0.backgroundColor = UIColor.white
            $0.delegate = self
            $0.dataSource = self
            $0.separatorStyle = .none
            $0.tableFooterView = UIView()
            $0.register(OAuthorCell.self, forCellReuseIdentifier: "CELLID")
            $0.showsVerticalScrollIndicator = false
            $0.isScrollEnabled = false
        }
        bgView.addSubview(tableView)
        
        changeBtn = UIButton().then {
            $0.setTitle("换一换", for: .normal)
            $0.setTitleColor(UIColor.black, for: .normal)
            $0.cornerRadius = 1
            $0.borderColor = UIColor.black
            $0.borderWidth = 0.5
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 10, weight: UIFontWeightThin)
            $0.rx.tap.subscribe(onNext: {[weak self] _ in
                guard let strongSelf = self else {
                    return
                }
                let temp = strongSelf.index + 3
                strongSelf.index = (temp == 9 ? 0 : temp)
                let indexPatch = NSIndexPath(item: strongSelf.index, section: 0)
                self?.tableView.scrollToRow(at: indexPatch as IndexPath, at: .top, animated: false)
            }).disposed(by: disposeBag)
        }
        bgView.addSubview(changeBtn)
        
        bgView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.contentView)
            make.top.equalTo(self.contentView.snp.top).offset(kMargin)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(bgView.snp.left).offset(kMargin * 1.5)
            make.top.equalTo(bgView.snp.top)
            make.height.equalTo(30)
            make.right.equalTo(bgView.snp.right).offset(-kMargin * 1.5)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom)
            make.left.right.equalTo(nameLabel)
            make.height.equalTo(50 * 3.0)
        }
        
        changeBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(bgView.snp.centerX)
            make.top.equalTo(tableView.snp.bottom).offset(kMargin * 2)
            make.width.equalTo(70)
            make.height.equalTo(30)
        }
    }
}

extension OHotAuthorCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELLID") as? OAuthorCell
        cell?.author = datas[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

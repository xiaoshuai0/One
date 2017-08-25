//
//  OSettingViewController.swift
//  One-Swift
//
//  Created by 赵帅 on 2017/8/11.
//  Copyright © 2017年 sun5kong. All rights reserved.
//

import UIKit

class OSettingViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "设置"
        self.view.backgroundColor = UIColor.white
        let tableView = UITableView(frame: self.view.bounds, style: .plain).then {
            $0.backgroundColor = kRGBA(238, g: 236, b: 243, a: 1)
            $0.tableFooterView = UIView()
            $0.delegate = self
            $0.dataSource = self
            $0.register(SettingCell.self, forCellReuseIdentifier: "CELLID")
            $0.register(OSetTitleHeaderView.self, forHeaderFooterViewReuseIdentifier: "Header")
        }
        self.view.addSubview(tableView)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    

}


extension OSettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        case 1:
            return 3
        case 2:
            return 2
        case 3:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELLID") as? SettingCell
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                cell?.type = .switchBtn
                cell?.nameLabel.text = "夜间模式"
            } else if indexPath.row == 1 {
                cell?.type = .switchBtn
                cell?.nameLabel.text = "开启省流量模式"
            } else {
                cell?.type = .normal
                cell?.nameLabel.text = "清理缓存"
            }
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                cell?.type = .normal
                cell?.nameLabel.text = "意见与反馈"
            } else if indexPath.row == 1 {
                cell?.type = .normal
                cell?.nameLabel.text = "关注我们"
            } else {
                cell?.type = .normal
                cell?.nameLabel.text = "给一个评分"
            }
        } else if indexPath.section == 2 {
            if indexPath.row == 0 {
                cell?.type = .normal
                cell?.nameLabel.text = "用户协议"
            } else {
                cell?.type = .detail
                cell?.nameLabel.text = "版本号"
                cell?.detailLabel.text = "4.3.0"
            }
        } else {
            cell?.nameLabel.text = "退出登录"
            cell?.type = .normal
            cell?.accessoryType = .none
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 3 {
            UserDefaults.standard.set("", forKey: "login")
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section != 3 {
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "Header") as? OSetTitleHeaderView
            if section == 0 {
                headerView?.titleLabel.text = "设置"
            } else if section == 1 {
                headerView?.titleLabel.text = "反馈"
            } else {
                headerView?.titleLabel.text = "关于"
            }
            return headerView!
        } else {
            let headerView = UIView()
            headerView.backgroundColor = kRGBA(238, g: 236, b: 243, a: 1)
            return headerView
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section != 3 {
            return 40
        }
        return 20
    }
    
    
    
}









































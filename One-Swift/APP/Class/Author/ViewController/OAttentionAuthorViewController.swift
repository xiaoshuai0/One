//
//  OAttentionAuthorViewController.swift
//  One-Swift
//
//  Created by 赵帅 on 2017/8/24.
//  Copyright © 2017年 sun5kong. All rights reserved.
//
/**
    关注的作者
 */
import UIKit

class OAttentionAuthorViewController: BaseViewController {

    fileprivate var tableView: UITableView!
    fileprivate let viewmodel = OAttentionService()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "我的关注"
        setupUI()
        viewmodel.loadAuthors() { (error) in
            self.tableView.reloadData()
        }
    }

    
    fileprivate func setupUI() {
        
        tableView = UITableView(frame: self.view.bounds, style: .plain).then {
            $0.separatorStyle = .none
            $0.tableFooterView = UIView()
            $0.delegate = self
            $0.dataSource = self
            $0.register(OAuthorCell.self, forCellReuseIdentifier: "CELLID")
            $0.backgroundColor = kRGBA(238, g: 236, b: 243, a: 1)
        }
        self.view.addSubview(tableView)
    }
    

}


extension OAttentionAuthorViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewmodel.authors.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELLID") as? OAuthorCell
        cell?.author = viewmodel.authors[indexPath.section]
        cell?.attentionBtn.isHidden = true
        cell?.accessoryType = .disclosureIndicator
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return kMargin
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView()
        footer.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kMargin)
        footer.backgroundColor = kRGBA(238, g: 236, b: 243, a: 1)
        return footer
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let authorVC = OAuthorDetailViewController()
        authorVC.author = viewmodel.authors[indexPath.section]
        self.navigationController?.pushViewController(authorVC, animated: true)
    }
}

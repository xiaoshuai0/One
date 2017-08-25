//
//  OAuthorDetailViewController.swift
//  One-Swift
//
//  Created by 赵帅 on 2017/8/24.
//  Copyright © 2017年 sun5kong. All rights reserved.
//

import UIKit

class OAuthorDetailViewController: BaseViewController {

    var author: OHotAuthor!
    fileprivate var tableView: UITableView!
    fileprivate var viewModel: AuthorService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        viewModel = AuthorService(author_id: author.user_id)
        self.loadData()
        self.setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.zs_setElementsAlpha(alpha: 0)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.zs_setElementsAlpha(alpha: 1.0)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}

extension OAuthorDetailViewController {
    fileprivate func loadData() {
        DispatchQueue.global().async {
            self.viewModel.loadAuthorArticle { [weak self](error) in
                guard let strong = self else {
                    return
                }
                DispatchQueue.main.async {
                    strong.tableView.reloadData()
                    if error == .noMoreData {
                        strong.tableView.mj_footer.endRefreshingWithNoMoreData()
                        strong.tableView.mj_footer.isHidden = true
                    } else {
                        strong.tableView.mj_footer.isHidden = false
                        strong.tableView.mj_footer.endRefreshing()
                    }

                }
            }
        }
        
    }
}
extension OAuthorDetailViewController {

    fileprivate func setupUI() {
        self.automaticallyAdjustsScrollViewInsets = false
        
        tableView = UITableView(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight), style: .plain)
        tableView.backgroundColor = kRGBA(227, g: 226, b: 231, a: 0)
//        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.tableHeaderView = OAuthorHeaderView(frame: CGRect.init(x: 0, y: 64, width: kScreenWidth, height: 0), author: author)
        
        tableView.register(OHomeItemCell.self, forCellReuseIdentifier: "CELLID")
        tableView.mj_footer = OCustomeRefreshFooter(refreshingBlock: { [unowned self] _ in
            self.loadData()
        })
        tableView.mj_footer.isHidden = true
        self.view.addSubview(tableView)
    }

}

extension OAuthorDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.ariticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELLID") as? OHomeItemCell
        cell?.model = viewModel.ariticles[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = viewModel.ariticles[indexPath.row]
        return model.height + kMargin
    }
}

extension OAuthorDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        
        var alpha = offsetY / 120.0
        if alpha > 1 {
            alpha = 1
        } else if alpha < 0{
            alpha = 0
        }
        if alpha == 1 {
            self.navigationItem.title = author.user_name
        } else {
            self.navigationItem.title = ""
        }
        self.navigationController?.navigationBar.zs_setElementsAlpha(alpha: alpha)
    }
}

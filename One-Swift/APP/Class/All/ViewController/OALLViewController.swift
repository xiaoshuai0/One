//
//  OALLViewController.swift
//  One-Swift
//
//  Created by 赵帅 on 2017/8/4.
//  Copyright © 2017年 sun5kong. All rights reserved.
//

import UIKit
import MJRefresh

class OALLViewController: BaseViewController {

    fileprivate var tableView: UITableView!
    fileprivate var server = OAllService()
    fileprivate var bannerView: OBannerView!
    fileprivate var loadingView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        let fps = OFPSLabel(frame: CGRect.init(x: 0, y: 64, width: 0, height: 0))
        self.view.addSubview(fps)
        server.complete.asObservable().subscribe(onNext: { [weak self] _ in
            self?.tableView.reloadData()
            self?.tableView.mj_header.endRefreshing()
            self?.tableView.mj_footer.endRefreshing()
        }).disposed(by: disposeBag)
        
        server.complete.asObservable().skip(1).take(1).subscribe(onNext: {[weak self] success in
            if success {
                self?.loadingView.stopAnimating()
                self?.loadingView.isHidden = true
                self?.loadingView.removeFromSuperview()
                self?.tableView.isHidden = false
            }
        }).disposed(by: disposeBag)
        
        server.noMoreData.asObservable().filter { $0 }.subscribe(onNext: { [weak self] _ in
            self?.tableView.mj_footer.endRefreshingWithNoMoreData()
        }).addDisposableTo(disposeBag)
        
        server.bannerData.asObservable()
            .subscribe(onNext: { [weak self] bannerData in
                self?.bannerView.datas = bannerData
            })
            .addDisposableTo(disposeBag)
        server.loadNewData()
    }

}

//MARK: UI
extension OALLViewController {
    fileprivate func setupUI() {
        setupNav()
        setupTableView()
        loadingView = UIImageView().then{
            $0.playGif("loading_book@3x.gif")
            $0.frame.size = CGSize(width: 60, height: 60)
            $0.center = self.view.center
        }
        self.view.addSubview(loadingView)
    }
    
    fileprivate func setupNav() {
        let imageView = UIImageView().then {
            $0.image = UIImage(named: "all_title_view")
            $0.contentMode = .scaleAspectFit
            $0.sizeToFit()
        }
        self.navigationItem.titleView = imageView
        
        let searchBtn = UIButton().then {
            $0.setImage(UIImage(named: "search_gray"), for: .normal)
            $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: -kMargin, bottom: 0, right: 0)
            $0.sizeToFit()
            $0.rx.tap.subscribe(onNext: {
                kLog("search")
            }).disposed(by: disposeBag)
        }
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchBtn)
    }
    
    fileprivate func setupTableView() {
        tableView = UITableView(frame: self.view.bounds, style: .plain).then {
            $0.backgroundColor = kRGBA(243, g: 243, b: 243, a: 1)
            $0.tableFooterView = UIView()
            $0.delegate = self
            $0.dataSource = self
            $0.separatorStyle = .none
            $0.register(OAllCategoryCell.self, forCellReuseIdentifier: "CELLID1")
            $0.register(OTopicCell.self, forCellReuseIdentifier: "CELLID2")
            $0.register(OQuestionCell.self, forCellReuseIdentifier: "CellID3")
            $0.register(OHotAuthorCell.self, forCellReuseIdentifier: "CELLID4")
            $0.isHidden = true
            $0.mj_header = OCustomeRefreshHeader(refreshingBlock: { [weak self] in
                self?.server.loadNewData()
            })
            $0.mj_footer = OCustomeRefreshFooter(refreshingBlock: { [weak self] in
                self?.server.loadMoreData()
            })
        }
        self.view.addSubview(tableView)
        
        bannerView = OBannerView(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight / 3))
        bannerView.selectedItem = { [weak self] item in
            guard let strong = self else {
                return
            }

            let detailVC = OArticleViewController()
            detailVC.id = "\(item.id)"
            detailVC.content_id = "\(item.content_id)"
            strong.navigationController?.pushViewController(detailVC, animated: true)
        }
        tableView.tableHeaderView = bannerView
    }
}

extension OALLViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = server.topicData.value.count
        
        if  server.authorData.value.count > 1{
            count += 1
        }
        
        if server.questionData.value.count > 1 {
            count += 1
        }
        
        return count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CELLID1") as? OAllCategoryCell
            return cell!
        } else if indexPath.row == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CellID3") as? OQuestionCell
            cell?.datas = server.questionData.value
            return cell!
        } else if indexPath.row == 5 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CELLID4") as? OHotAuthorCell
            cell?.datas = server.authorData.value
            return cell!
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CELLID2") as? OTopicCell
            if indexPath.row < 4 {
                cell?.model = server.topicData.value[indexPath.row - 1]
            } else {
                cell?.model = server.topicData.value[indexPath.row - 3]
            }
            
            return cell!
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row != 0 && indexPath.row != 4 && indexPath.row != 5 {
            let detailVC = OArticleViewController()
            var model: OAllCommonModel? = nil
            if indexPath.row < 4 {
                model = server.topicData.value[indexPath.row - 1]
            } else {
                model = server.topicData.value[indexPath.row - 3]
            }
            detailVC.id = "\(String(describing: model?.id))"
            detailVC.content_id = model?.content_id
            detailVC.category = "topic"
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 230
        } else if indexPath.row == 4 {
            return 170
        } else if indexPath.row == 5 {
            return 260
        } else {
            var model: OAllCommonModel? = nil
            if indexPath.row < 4 {
                model = server.topicData.value[indexPath.row - 1]
            } else {
                model = server.topicData.value[indexPath.row - 3]
            }
            return 275 + model!.topicHeight
        }
        
    }
}

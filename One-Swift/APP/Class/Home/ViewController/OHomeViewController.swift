//
//  OHomeViewController.swift
//  One-Swift
//
//  Created by 赵帅 on 2017/8/4.
//  Copyright © 2017年 sun5kong. All rights reserved.
//

import UIKit
import Moya
import RxSwift
import Kingfisher
import RxCocoa
import RxDataSources

class OHomeViewController: BaseViewController {

    fileprivate let viewmodel = OHomeViewModel()
    fileprivate var tableView: UITableView!
    fileprivate var show: Bool = false
    fileprivate var weatherView: UIView!
    fileprivate var dateView: UIView!
    fileprivate var weatherLabel: UILabel!
    fileprivate var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        let fps = OFPSLabel(frame: CGRect.init(x: 0, y: 64, width: 0, height: 0))
        self.view.addSubview(fps)
        viewmodel.loadNewData { (error) in
            switch error {
            case .none:
                kLog("刷新界面")
//                self.navigationItem.title = self.viewmodel.weather
                self.weatherLabel.text = self.viewmodel.weather
                self.dateLabel.text = self.viewmodel.date
                self.tableView.reloadData()
            case .jsonError:
                kLog("json出错")
            case .noMoreData:
                kLog("没有更多数据")
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let statusbar = UIApplication.shared.value(forKey: "statusBar") as? UIView
        
        statusbar?.addSubview(weatherView)
        statusbar?.addSubview(dateView)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        weatherView.removeFromSuperview()
        dateView.removeFromSuperview()
    }
}


extension OHomeViewController {

    fileprivate func setupUI() {
        self.view.backgroundColor = kRGBA(243, g: 243, b: 243, a: 1)
        
        setupNav()
        setupTableView()
        self.hideTabBar(tabBarController: self.tabBarController!)
    }
    
    fileprivate func setupNav() {
        let searchBtn = UIButton().then {
            $0.setImage(UIImage(named: "search_dark"), for: .normal)
            $0.sizeToFit()
        }
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchBtn)
        
        weatherView = UIView()
        weatherView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 64)
        weatherView.backgroundColor = .white
        weatherLabel = UILabel.createLabel(.zero, font: FONT10, textColor: .black, textAlignment: .center, text: "")
        weatherLabel.frame = CGRect(x: 0, y: 64 - 5 - 15, width: kScreenWidth, height: 15)
        weatherView.addSubview(weatherLabel)
        
        dateView = UIView()
        dateView.frame = weatherView.frame
        dateView.backgroundColor = UIColor.clear
        
        dateLabel = UILabel.createLabel(.zero, font: UIFont.systemFont(ofSize: 17, weight: UIFontWeightThin), textColor: .black, textAlignment: .center, text: "")
        dateLabel.frame = CGRect(x: 0, y: 10, width: kScreenWidth, height: 20)
        dateView.addSubview(dateLabel)
    }
    
    fileprivate func setupTableView() {
        tableView = UITableView(frame: self.view.bounds, style: .plain).then {
            $0.tableFooterView = UIView()
            $0.separatorStyle = .none
            $0.backgroundColor = kRGBA(243, g: 243, b: 243, a: 1)
            $0.delegate = self
            $0.dataSource = self
            $0.register(OHomeItemCell.self, forCellReuseIdentifier: "CELLID")
            $0.register(OHomeFirstItemCell.self, forCellReuseIdentifier: "firstCell")
            
            $0.register(UINib(nibName: "MenuCell", bundle: nil), forCellReuseIdentifier: "cellMenu")
        }
        self.view.addSubview(tableView)
    }
}


extension OHomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var count = viewmodel.content_list.count
        if viewmodel.menu != nil {
            count += 1
        }
        return count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 1 {
            if show {
                guard let count =  viewmodel.menu?.list?.count else {
                    return 0
                }
                return count
            } else {
                return 0
            }
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "firstCell") as? OHomeFirstItemCell
            cell?.model = viewmodel.content_list[indexPath.section]
            return cell!
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellMenu") as? MenuCell
            cell?.menu = viewmodel.menu!.list![indexPath.row]
            return cell!
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CELLID") as? OHomeItemCell
            cell?.model = viewmodel.content_list[indexPath.section - 1]
            return cell!
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            let model = viewmodel.content_list[0]
            return 530 + model.firstDescHeight
        } else if indexPath.section == 1 {
            return 60
        }
        let model = viewmodel.content_list[indexPath.section - 1]
        return model.height + kMargin
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let menu = OMenuView(frame: .zero)
            menu.action = { [weak self] _ in
                guard let strongSelf = self else {
                    return
                }
                strongSelf.show = !strongSelf.show
                strongSelf.tableView.reloadData()
            }
            menu.show = show
            menu.changeBtn.setTitle("一个 VOL. \(viewmodel.menu!.vol)", for: .normal)
            return menu
        }
        return nil
    }
    

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 50
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section > 1 {
            let model = viewmodel.content_list[indexPath.section - 1]
            kLog("\(model.id)---------\(model.content_id)")
            let vc = OArticleViewController()
            vc.id = model.id
            vc.content_id = model.content_id
            switch model.category {
            case "1":
                vc.category = "essay"
            case "2":
                vc.category = "serialcontent"
            case "3":
                vc.category = "question"
            case "4":
                vc.category = "music"
            case "5":
                vc.category = "movie"
            default:
                vc.category = ""
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension OHomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        var alpha = offsetY / 100.0
        if alpha < 0 {
            alpha = 0
        } else if alpha > 1 {
            alpha = 1
        }
        if offsetY <= 0 {
            self.hideTabBar(tabBarController: self.tabBarController!)
        } else {
            self.showTabBar(tabBarController: self.tabBarController!)
        }
        weatherView.alpha = 1 - alpha
        dateLabel.frame = CGRect(x: 0, y: 10 + 20 * alpha, width: kScreenWidth, height: 20)
    }
}

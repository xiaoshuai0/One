//
//  OMeViewController.swift
//  One-Swift
//
//  Created by 赵帅 on 2017/8/4.
//  Copyright © 2017年 sun5kong. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Then

class OMeViewController: BaseViewController {
    
    fileprivate var loginFlag = Variable<Bool>(true)
    fileprivate var messageButton: UIButton!
    fileprivate var titleView: UILabel!
    fileprivate var loginView: UIImageView!
    fileprivate var tableView: UITableView!
    fileprivate var headerView: OMeHeaderView!
    fileprivate var viewModel = OMeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()

        loginFlag.asDriver().distinctUntilChanged().map{ !$0 }.drive(messageButton.rx.isHidden).disposed(by: disposeBag)
        loginFlag.asDriver().distinctUntilChanged().map{ !$0 }.drive(titleView.rx.isHidden).disposed(by: disposeBag)
        loginFlag.asDriver().distinctUntilChanged().drive(loginView.rx.isHidden).disposed(by: disposeBag)
        loginFlag.asDriver().distinctUntilChanged().map{ !$0 }.drive(tableView.rx.isHidden).disposed(by: disposeBag)
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.zs_setElementsAlpha(alpha: 0)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loginFlag.value = kisLogin()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.delegate = nil
        self.navigationController?.navigationBar.zs_setElementsAlpha(alpha: 1.0)
    }

}


//MARK: UI
extension OMeViewController {
    fileprivate func setupUI() {
        
        setupNav()
        setupLoginView()
        setupTableView()
    }
    /** nav*/
    fileprivate func setupNav() {
        
//        self.navigationController?.navigationBar.zs_setElementsAlpha(alpha: 0)
        
        let settingBtn = UIButton.createButton("user_center_setting", title: nil)
        settingBtn.sizeToFit()
        settingBtn.rx.tap
            .subscribe(onNext: {
                kLog("设置按钮")
                self.navigationController?.pushViewController(OSettingViewController(), animated: true)
            })
            .disposed(by: disposeBag)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: settingBtn)
        
        messageButton = UIButton().then {
            $0.setImage(UIImage(named: "user_message_white"), for: .normal)
            $0.contentEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
            $0.sizeToFit()
            $0.rx.tap.subscribe(onNext: {
                MyThemes.switchNight(isToNight: false)
            }).disposed(by: disposeBag)
        }
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: messageButton)
        
        titleView = UILabel().then {
            $0.text = "Sun5kong"
            $0.font = FONT14
            $0.textColor = UIColor.black
            $0.textAlignment = .center
            $0.sizeToFit()
            $0.alpha = 0
        }
        self.navigationItem.titleView = titleView
    }
    
    fileprivate func setupLoginView() {
        loginView = UIImageView()
        loginView.image = UIImage(named: "colored_bg_image")
        loginView.frame = self.view.bounds
        loginView.isUserInteractionEnabled = true
        self.view.addSubview(loginView)
        
        setupLoginBtn()
    }
    
    fileprivate func setupLoginBtn() {
        
        let loginBtn = OLoginButton(frame: .zero)
        loginBtn.loginAction.asObservable().skip(1).subscribe(onNext: { [weak self] _ in
            print("登录")
            let loginVC = OLoginViewController()
            self?.navigationController?.delegate = self
            self?.navigationController?.pushViewController(loginVC, animated: true)
        }).disposed(by: disposeBag)
        loginView.addSubview(loginBtn)
        
        loginBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(loginView.snp.centerX)
            make.top.equalTo(loginView.snp.top).offset(150)
            make.width.equalTo(60)
            make.height.equalTo(70)
        }
    }
    
    
    fileprivate func setupTableView() {
        tableView = UITableView(frame: self.view.bounds, style: .plain).then {
            $0.delegate = self
            $0.dataSource = self
            $0.tableFooterView = UIView()
            $0.separatorStyle = .none
            $0.register(OMeNomalCell.self, forCellReuseIdentifier: "CELLID")
            $0.register(OMeCollectionCell.self, forCellReuseIdentifier: "CollectionCellID")
            $0.theme_backgroundColor = globalBackgroundColorPicker
            $0.backgroundColor = kRGBA(238, g: 236, b: 243, a: 1)
        }
        headerView = OMeHeaderView(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight * 0.5))
        tableView.tableHeaderView = headerView
        viewModel.noteModel.drive(headerView.model).disposed(by: disposeBag)
        self.view.addSubview(tableView)
    }
}


extension OMeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionCellID") as? OMeCollectionCell
            return cell!
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELLID") as? OMeNomalCell
        if indexPath.section == 1 {
            cell?.textLabel?.text = "我的关注"
            cell?.imageView?.image = UIImage(named: "user_center_following")
        } else {
            cell?.textLabel?.text = "歌单"
            cell?.imageView?.image = UIImage(named: "music_list")
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 120
        }
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kMargin)
        view.backgroundColor = kRGBA(238, g: 236, b: 243, a: 1)
        return view
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 2 {
            let label = UILabel().then {
                $0.textColor = UIColor.black
                $0.text = "已经全部加在完毕"
                $0.textAlignment = .center
                $0.font = FONT14
                $0.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 40)
            }
            return label
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            self.navigationController?.pushViewController(OAttentionAuthorViewController(), animated: true)
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kMargin
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return section == 2 ? 40 : 0
    }
}

extension OMeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        headerView.offY.value = scrollView.contentOffset.y
        let alpha = scrollView.contentOffset.y / 200
        self.navigationController?.navigationBar.zs_setElementsAlpha(alpha: alpha)
        titleView.alpha = alpha
    }
}


extension OMeViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            return OPushFromBottomAnimation()
        } else {
            return nil
        }
    }
}

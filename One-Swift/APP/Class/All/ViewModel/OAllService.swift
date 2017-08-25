//
//  OAllService.swift
//  One-Swift
//
//  Created by 赵帅 on 2017/8/15.
//  Copyright © 2017年 sun5kong. All rights reserved.
//

import UIKit
import Moya
import RxSwift
import ObjectMapper

class OAllService: NSObject {
    /** 作家数据*/
    var authorData: Variable<[OHotAuthor]> = Variable([])
    /** 广告页*/
    var bannerData: Variable<[OAllCommonModel]> = Variable([])
    /** 问题*/
    var questionData: Variable<[OAllCommonModel]> = Variable([])
    /** 专题*/
    var topicData: Variable<[OAllCommonModel]> = Variable([])
    /** 请求完成*/
    var complete:Variable<Bool> = Variable(false)
    
    var noMoreData: Variable<Bool> = Variable(false)
    
    let disposeBag = DisposeBag()
    let provider = RxMoyaProvider<ApiManager>()
    /** 最后一期请请求*/
    fileprivate var lastTopicID: Int?
    
    override init() {
        
        
        
    }
    
    
    func loadNewData() {
        
        let author = provider.request(.hotAuthor).mapModelArray(OHotAuthor.self)
        let banner = provider.request(.allBannerUrl("0")).mapModelArray(OAllCommonModel.self)
        let question = provider.request(.allQuestionUrl("0")).mapModelArray(OAllCommonModel.self)
        let topic = provider.request(.allTopic("0")).mapModelArray(OAllCommonModel.self)
        
        
        author.bind(to: authorData).disposed(by: disposeBag)
        banner.bind(to: bannerData).disposed(by: disposeBag)
        question.bind(to: questionData).disposed(by: disposeBag)
        topic.bind(to: topicData).disposed(by: disposeBag)
        
        topicData.asObservable().subscribe(onNext: { [weak self](datas) in
            self?.lastTopicID = datas.last?.id
        }).addDisposableTo(disposeBag)
        
        Observable.zip(author, banner, question, topic) { authorD, bannerD, questionD, topicD -> Bool in
            return true
        }.bind(to: complete).disposed(by: disposeBag)
    }
    
    
    /** 加载更多数据*/
    func loadMoreData() {
        let topic = provider.request(.allTopic("\(lastTopicID!)")).mapModelArray(OAllCommonModel.self)
        topic.subscribe(onNext: { [weak self](datas) in
            self?.topicData.value.append(contentsOf: datas)
            self?.complete.value = true
        }).addDisposableTo(disposeBag)
        
        topic.subscribe(onNext: {[weak self] data in
            if data.count == 0 {
                kLog("没有更多数据")
                self?.noMoreData.value = true
            }
        }, onError: { (error) in
            print(error)
        }).disposed(by: disposeBag)
    }
}






//        let group = DispatchGroup()
//
//        let queue = DispatchQueue.global()
//        //banner数据
//        group.enter()
//        queue.async(group: group) {
//            NetworkUtil.shared.getForJSON(url: allBannerUrl, paramters: nil, finished: { [weak self](json, error) in
//                if error == nil {
//                    guard let json = json?.dictionaryObject, let data = json["data"] as? [[String: Any]], data.count > 0 else {
//                        return
//                    }
//                    let banner = Mapper<OAllCommonModel>().mapArray(JSONArray: data)
//                    self?.bannerData.value.append(contentsOf: banner)
//                } else {
//
//                }
//                group.leave()
//            })
//        }
//        //所有人
//        group.enter()
//        queue.async(group: group) {
//            NetworkUtil.shared.getForJSON(url: allQuestionUrl, paramters: nil, finished: { [weak self](json, error) in
//                if error == nil {
//                    guard let json = json?.dictionaryObject, let data = json["data"] as? [[String: Any]], data.count > 0 else {
//                        return
//                    }
//                    let banner = Mapper<OAllCommonModel>().mapArray(JSONArray: data)
//                    self?.questionData.value.append(contentsOf: banner)
//                }
//                group.leave()
//            })
//
//        }
//        //热门作家
//        group.enter()
//        queue.async(group: group) {
//            NetworkUtil.shared.getForJSON(url: hotAuthorUrl, paramters: nil, finished: { [weak self](json, error) in
//                if error == nil {
//                    guard let json = json?.dictionaryObject, let data = json["data"] as? [[String: Any]], data.count > 0 else {
//                        return
//                    }
//                    let banner = Mapper<OHotAuthor>().mapArray(JSONArray: data)
//                    self?.authorData.value.append(contentsOf: banner)
//                }
//                group.leave()
//            })
//        }
//        //专题
//        group.enter()
//        queue.async(group: group) {
//            NetworkUtil.shared.getForJSON(url: allTopicUrl, paramters: nil, finished: { [weak self](json, error) in
//                if error == nil {
//                    guard let json = json?.dictionaryObject, let data = json["data"] as? [[String: Any]], data.count > 0 else {
//                        return
//                    }
//                    let banner = Mapper<OAllCommonModel>().mapArray(JSONArray: data)
//                    self?.topicData.value.append(contentsOf: banner)
//                }
//                group.leave()
//            })
//        }
//        group.notify(queue: DispatchQueue.main) {
//
//            kLog("完成")
//        }

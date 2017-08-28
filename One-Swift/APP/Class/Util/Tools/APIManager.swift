//
//  APIManager.swift
//  One-Swift
//
//  Created by 赵帅 on 2017/8/4.
//  Copyright © 2017年 sun5kong. All rights reserved.
//

import UIKit
import Moya
import RxSwift
import SwiftyJSON

let hotAuthorUrl = "http://v3.wufazhuce.com:8000/api/author/hot?platform=ios&sign=96fdd1425950625d286125cab4db758a&user_id=8225952&uuid=5B9F569B-8E21-413C-8602-E33BBD201525&version=v4.3.0"
let allBannerUrl = "http://v3.wufazhuce.com:8000/api/banner/list/3?last_id=0&platform=ios&sign=051297544ebd2ca08d1bddcd0584b386&user_id=8225952&uuid=5B9F569B-8E21-413C-8602-E33BBD201525&version=v4.3.0"
let allQuestionUrl = "http://v3.wufazhuce.com:8000/api/banner/list/5?last_id=0&platform=ios&sign=051297544ebd2ca08d1bddcd0584b386&user_id=8225952&uuid=5B9F569B-8E21-413C-8602-E33BBD201525&version=v4.3.0"
let allTopicUrl = "http://v3.wufazhuce.com:8000/api/banner/list/4?last_id=0&platform=ios&sign=051297544ebd2ca08d1bddcd0584b386&user_id=8225952&uuid=5B9F569B-8E21-413C-8602-E33BBD201525&version=v4.3.0"
let topicDetail = "http://v3.wufazhuce.com:8000/api/topic/htmlcontent/7?platform=ios&sign=ebd966342a93374cfa7927a616a99265&source=banner&source_id=6&user_id=8225952&uuid=5B9F569B-8E21-413C-8602-E33BBD201525&version=v4.3.1"
enum ApiManager {
    case getHomeList
    case hotAuthor
    case allBannerUrl(String)
    case allQuestionUrl(String)
    case allTopic(String)
    case topicDetail(String, String, String)
}


extension ApiManager: TargetType {
    
    var baseURL: URL {
        return URL(string: "http://v3.wufazhuce.com:8000/api/")!
    }
    
    var path: String {
        switch self {
        case .getHomeList:
            return "channel/one/0/北京市"
        case .hotAuthor:
            return "author/hot"
        case .allBannerUrl:
            return "banner/list/3"
        case .allQuestionUrl:
            return "banner/list/5"
        case .allTopic:
            return "banner/list/4"
        case let .topicDetail(topic , id,  _):
            return "\(topic)/htmlcontent/\(id)"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .getHomeList, .hotAuthor:
            return [
                "platform": "ios",
                "sign":     "96fdd1425950625d286125cab4db758a",
                "user_id":  "8225952",
                "uuid":     "5B9F569B-8E21-413C-8602-E33BBD201525",
                "version":  "v4.3.0"
            ]
        case let .allBannerUrl(id):
            return [
                "last_id": id,
                "platform": "ios",
                "sign":     "96fdd1425950625d286125cab4db758a",
                "user_id":  "8225952",
                "uuid":     "5B9F569B-8E21-413C-8602-E33BBD201525",
                "version":  "v4.3.0"
            ]
        case let .allQuestionUrl(id):
            return [
                "last_id": id,
                "platform": "ios",
                "sign":     "96fdd1425950625d286125cab4db758a",
                "user_id":  "8225952",
                "uuid":     "5B9F569B-8E21-413C-8602-E33BBD201525",
                "version":  "v4.3.0"
            ]
        case let .allTopic(id):
            return [
                "last_id": id,
                "platform": "ios",
                "sign":     "96fdd1425950625d286125cab4db758a",
                "user_id":  "8225952",
                "uuid":     "5B9F569B-8E21-413C-8602-E33BBD201525",
                "version":  "v4.3.0"
            ]
        case let .topicDetail(_, _, content_id):
            return [
                "source_id": content_id,
                "platform": "ios",
                "sign":     "96fdd1425950625d286125cab4db758a",
                "user_id":  "8225952",
                "uuid":     "5B9F569B-8E21-413C-8602-E33BBD201525",
                "version":  "v4.3.0"
            ]
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.queryString
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        return .request
    }
    
    var validate: Bool {
        return false
    }
    
    
}

extension RxMoyaProvider {

    
    func tryUseOfflineCacheThenRequest(token: Target) -> Observable<JSON> {
        return Observable.create { [weak self] observer -> Disposable in
            
            // 先读取缓存内容，有则发出一个信号（onNext），没有则跳过
            if let response = NetworkCache.shared.getHttpCache(url: token.baseURL.absoluteString + token.path, parameters: token.parameters) {
                observer.onNext(response)
            }
            
            // 发出真正的网络请求
            let cancelableToken = self?.request(token) { result in
                switch result {
                case let .success(response):
                    let json = JSON(response.data)
                    observer.onNext(json)
                    observer.onCompleted()
                    NetworkCache.shared.setHttpCache(response.data, url: token.baseURL.absoluteString + token.path, parameters: token.parameters)
                    
                case let .failure(error):
                    observer.onError(error)
                }
            }
            
            return Disposables.create {
                cancelableToken?.cancel()
            }
        }
    }
}

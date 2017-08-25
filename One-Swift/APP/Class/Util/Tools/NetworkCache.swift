//
//  NetworkCache.swift
//  One-Swift
//
//  Created by 赵帅 on 2017/8/4.
//  Copyright © 2017年 sun5kong. All rights reserved.
//

import UIKit
import Foundation
import YYCache
import SwiftyJSON

class NetworkCache {
    
    //单例
    static let shared = NetworkCache()
    private var dataCache: YYCache!
    private let NetworkResponseCache = "NetworkResponseCache"
    
    //私有化构造方法
    private init() {
        DispatchQueue.once(token: "YYCache") { 
            dataCache = YYCache(name: NetworkResponseCache)
        }
    }
    
    public func setHttpCache(_ httpData: Data?, url: String, parameters: [String: Any]?) {
        guard let httpData = httpData else {
            return
        }
        let cacheKey = self.cacheKey(url, parameters: parameters)
        //异步缓存, 不会阻塞线程
        dataCache.setObject(httpData as NSData, forKey: cacheKey)
        
    }
    
    public func getHttpCache(url: String, parameters: [String: Any]?) -> JSON? {
        let cacheKey = self.cacheKey(url, parameters: parameters)
        let data = dataCache.object(forKey: cacheKey) as? NSData
        guard let tmp = data else {
            return nil
        }
        return JSON(tmp)
    }
    
    public func getAllHttpCacheSize() -> Int {
        return dataCache.diskCache.totalCost()
    }
    
    public func removeAllHttpCache() {
        dataCache.diskCache.removeAllObjects()
        dataCache.memoryCache.removeAllObjects()
    }
}

extension NetworkCache {
    
    fileprivate func cacheKey(_ url: String, parameters: [String: Any]?) -> String {
        guard let params = parameters else {
            return url
        }
        
        let data = try? JSONSerialization.data(withJSONObject: params, options: [])
        guard let tmpData = data else {
            return url
        }
        let paraString = NSString(data: tmpData, encoding: String.Encoding.utf8.rawValue)
        let key = "\(url)\(String(describing: paraString))"
        return key
    }
}





























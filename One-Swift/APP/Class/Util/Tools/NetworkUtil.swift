//
//  NetworkUtil.swift
//  One-Swift
//
//  Created by 赵帅 on 2017/8/4.
//  Copyright © 2017年 sun5kong. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

//MARK: log方法
fileprivate func Log<T>(_ message: T, file: String = #file, funcName: String = #function, lineNum: Int = #line) {
    #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        print("\(fileName)---\(funcName)---\(lineNum): \(message)")
    #endif
}
// MARK: - Helpers
fileprivate extension String {
    var urlEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }
    
    var utf8Encoded: Data {
        return self.data(using: .utf8)!
    }
}

//MARK: md5加密
func md5(_ str: String) -> String {
    
    let cStr = str.cString(using: String.Encoding.utf8)
    let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: 16)
    CC_MD5(cStr!, (CC_LONG)(strlen(cStr)), buffer)
    let md5String = NSMutableString()
    for i in 0..<16 {
        md5String.appendFormat("%02x", buffer[i])
    }
    free(buffer)
    return md5String as String
}

enum RequestType {
    case GET
    case POST
}

class NetworkUtil {

    //MARK: 属性
    
    //单例
    static let shared = NetworkUtil()
    //私有化构造方法
    private init() {}
    /*
        JSON回调
     */
    typealias networkJSON = (_ json: JSON?, _ error: String?) -> ()
    /*
     网络状态监听
     */
    typealias networkListen = (_ status: NetworkReachabilityManager.NetworkReachabilityStatus) -> Void
    /*
        baseUrl
     */
    var baseUrl: String? = nil
    /*
        请求超时时间
     */
    var timeOut: TimeInterval = 5.0
    /*
        请求头
     */
    var httpHeader: HTTPHeaders? = nil
    /*
        是否自动log, 默认为yes
     */
    var isDebug = false
    /*
        url自动编码
     */
    var isAutoEncode = false
    /*
        网络异常是加载本地数据
     */
    var shouldObtainLocalWhenUnconnected = true
    
    /*
        当前网络状态, 默认wifi, 开启网络状态监听有效
     */
    var networkStatus = NetworkReachabilityManager.NetworkReachabilityStatus.reachable(.ethernetOrWiFi)
    let listen = NetworkReachabilityManager()
}

//MARK: 网络监听
extension NetworkUtil {
    public func listenNetworkReachabilityStatus(networkListen: @escaping networkListen) {
        listen?.startListening()
        
        listen?.listener = {[unowned self] status in
            self.networkStatus = status
            if self.isDebug {
                Log("*****<<<Network Status changed>>>*****:\(status)")
            }
            networkListen(status)
            if self.listen?.isReachable == false {//无网络状态
                self.networkStatus = .notReachable
                networkListen(self.networkStatus)
            }
        }
    }
}
//MARK:缓存相关
extension NetworkUtil {
    
    /// 获取所有缓存信息
    ///
    /// - Returns: 缓存大小
    public func getcacheSize() -> Int{
        return NetworkCache.shared.getAllHttpCacheSize()
    }
    
    /// 删除所有缓存
    public func removeAllCache() {
        NetworkUtil.shared.removeAllCache()
    }
    
}
//MARK:GET
extension NetworkUtil {

    public func getForJSON(url: String, paramters: [String: Any]?, responseCache: networkJSON?,finished: @escaping networkJSON) {
        requestJSON(methodType: .GET, urlString: url, paramters: paramters, responseCache: responseCache, finished: finished)
    }
    
    public func getForJSON(url: String, paramters: [String: Any]?, finished: @escaping networkJSON) {
        getForJSON(url: url, paramters: paramters, responseCache: nil, finished: finished)
    }
}
//MARK:PSOT
extension NetworkUtil {
    
    public func postForJSON(url: String, paramters: [String: Any]?, responseCache: networkJSON?,finished: @escaping networkJSON) {
        requestJSON(methodType: .POST, urlString: url, paramters: paramters, responseCache: responseCache, finished: finished)
    }
    
    public func postForJSON(url: String, paramters: [String: Any]?, finished: @escaping networkJSON) {
        postForJSON(url: url, paramters: paramters, responseCache: nil, finished: finished)
    }
}
//MARK: 公共请求类
extension NetworkUtil {
    
    fileprivate func requestJSON(methodType: RequestType, urlString: String, paramters: [String: Any]?, responseCache: networkJSON?, finished: @escaping networkJSON) {
        
        if self.networkStatus == .notReachable {
            finished(nil, "无网络")
        } else {
            //拼接URL
            var absoulteStr: String? = nil
            absoulteStr = absoulteURL(path: urlString)
            //转换url
            let tmpUrl = changeStringToURL(urlStr: absoulteStr)
            guard let url = tmpUrl else {
                return
            }
            //获取缓存
            if let responseCache = responseCache  {
                responseCache(NetworkCache.shared.getHttpCache(url: absoulteStr!, parameters: paramters), nil)
            }
            
            //判断请求方法
            let httpMethod: HTTPMethod = (methodType == .GET ? .get : .post)
//            let configuration = URLSessionConfiguration.default
//            configuration.timeoutIntervalForRequest = timeOut
//            let manager = Alamofire.SessionManager(configuration: configuration)
            
            Alamofire.request(url, method: httpMethod, parameters: paramters, encoding: URLEncoding.default, headers: httpHeader).responseJSON { (response) in
                //请求成功
                if response.result.isSuccess {
                    if let value = response.result.value {
                        let json = JSON(value)
                        if json != nil {
                            let data = try? json.rawData()
                            NetworkCache.shared.setHttpCache(data, url: absoulteStr!, parameters: paramters)
                        }
                        self.networkLogSuccess(json: json, url: absoulteStr!, params: paramters)
                        finished(json, nil)
                    } else {
                        self.networkLogFail(error: response.result.error as NSError?, url: absoulteStr!, params: paramters)
                        finished(nil, "服务器开小差, 请稍后访问")
                    }
                }
            }

        }
        
    }
    
    
}


//MARK: 私有方法
extension NetworkUtil {
    
    /*拼接URL*/
    fileprivate func absoulteURL(path: String?) -> String {
        
        if path == nil || path?.count == 0 {//
            if baseUrl != nil && baseUrl?.count != 0 {
                return baseUrl!
            }
            return ""
        }
        
        if baseUrl == nil || baseUrl?.count == 0 {
            return path!
        }
        
        var absoluteUrl = path!
        
        if !absoluteUrl.hasPrefix("http://") && !absoluteUrl.hasPrefix("https://") {
            if baseUrl!.hasSuffix("/") {
                if absoluteUrl.hasPrefix("/") {
                    var mutablePath = absoluteUrl
                    mutablePath.remove(at: mutablePath.index(mutablePath.startIndex, offsetBy: 0))
                    absoluteUrl = baseUrl! + mutablePath
                } else {
                    absoluteUrl = baseUrl! + path!
                }
            } else {
                if absoluteUrl.hasPrefix("/") {
                    absoluteUrl = baseUrl! + path!
                } else {
                    absoluteUrl = baseUrl! + "/" + path!
                }
            }
        }
        return absoluteUrl
    }
    
    fileprivate func changeStringToURL(urlStr: String?) -> URL? {
        guard let urlStr = urlStr else {
            return nil
        }
        
        var url = urlStr
        if isAutoEncode {
            url = urlStr.urlEscaped
            if isDebug {
                Log("Encode URL ===>\(url)")
            }
        }
        let tmpUrl: URL? = URL(string: url)
        guard let result = tmpUrl else {
            Log("UrlString无效, 无法生成URL. 可能是URL中有中文, 请尝试encode URL, absoulte = \(url)")
            return nil
        }
        return result
    }
    
    /**成功的日志输出***/
    fileprivate func networkLogSuccess(json: JSON?, url: String, params: [String: Any]?) {
        if isDebug {
            let absolute = absoulteURL(path: url)
            Log("请求成功🍎, 🌏 \(absolute) \nparams ==>> \(String(describing: params)) \nresponse ==>> \(String(describing: json))")
        }
    }
    /**失败的日志输出***/
    fileprivate func networkLogFail(error: NSError?, url: String, params: [String:Any]?) {
        if isDebug {
            let absolute = absoulteURL(path: url)
            if error?.code == NSURLErrorCancelled {
                Log("请求被取消🏠, 🌏 \(absolute) \nparams ==>> \(String(describing: params)) \n错误信息❌ ==>> \(String(describing: error))")
            } else {
                Log("请求错误, 🌏 \(absolute) \nparams ==>> \(String(describing: params)) \n错误信息❌ ==>> \(String(describing: error))")
            }
        }
    }
}

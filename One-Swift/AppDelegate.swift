//
//  AppDelegate.swift
//  One-Swift
//
//  Created by 赵帅 on 2017/8/4.
//  Copyright © 2017年 sun5kong. All rights reserved.
//

import UIKit

/**
 com.bmsoft.One-Swift
    shareSDK:  
        appkey: 2055f67ff7805    appsecret: 240c9e8bf4400a829b972a2cec3f15f6
    wechat:
        appkey: wxf66a047a97615a94 appsecret: 4247d43058cb9290d596d13e6b7a1357
 
 
 
 59a3c801a40fa30b43000ac5
 */
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, WXApiDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        /** 初始化window*/
        setupWindow()
        
        configNetWork()
        
        configTheme()
        
        configShareSDK()
        
        return true
    }

    private func setupWindow() {
        window = UIWindow()
        window?.frame = kScreenBounds
        window?.backgroundColor = .white
        window?.rootViewController = MainTabBarController()
        window?.makeKeyAndVisible()
    }
    
    
    private func configNetWork() {
        NetworkUtil.shared.isAutoEncode = true
    }
    
    private func configTheme() {
    
        MyThemes.restoreLastTheme()
        
        UIApplication.shared.theme_setStatusBarStyle([.lightContent, .default], animated: true)
        
        let navigationBar = UINavigationBar.appearance()
        let shadow = NSShadow()
        shadow.shadowOffset = CGSize(width: 0, height: 0)
        let titleAttributes: [String: AnyObject] = [
            NSForegroundColorAttributeName: UIColor.black,
            NSFontAttributeName: UIFont.systemFont(ofSize: 16),
            NSShadowAttributeName: shadow
        ]
        
        navigationBar.theme_tintColor = globalBarTextColorPicker
        navigationBar.theme_barTintColor = globalBarTintColorPicker
        navigationBar.titleTextAttributes = titleAttributes
        
        
        let tabBar = UITabBar.appearance()
        tabBar.theme_tintColor = globalBarTextColorPicker
        tabBar.theme_barTintColor = globalBarTintColorPicker
    }
    
    
    private func configShareSDK() {
    
        ShareSDK.registerActivePlatforms([SSDKPlatformType.typeQQ.rawValue,
                                          SSDKPlatformType.typeWechat.rawValue],
                                         onImport: { (platform) in
                                            switch platform
                                            {
                                            case SSDKPlatformType.typeWechat:
                                                ShareSDKConnector.connectWeChat(WXApi.classForCoder())
                                            default:
                                                break
                                            }
        }) { (platform, appInfo) in
            switch platform
            {
            
            case SSDKPlatformType.typeWechat:
                //设置微信应用信息
                appInfo?.ssdkSetupWeChat(byAppId: "wxf66a047a97615a94",
                                         appSecret: "989713f37362cc3900392ac570ce5478")

            default:
                break
            }
        }
    }
    
    
    
    
    
    
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        DispatchQueue.main.async {
            WXApi.handleOpen(url, delegate: self)
        }
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        DispatchQueue.main.async {
            WXApi.handleOpen(url, delegate: self)
        }
        return true
    }


    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        DispatchQueue.main.async {
            WXApi.handleOpen(url, delegate: self)
        }
        return true
    }
}


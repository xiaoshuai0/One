//
//  Global.swift
//  Ge
//
//  Created by 赵帅 on 2017/5/12.
//  Copyright © 2017年 zhaoshuai. All rights reserved.
//

import UIKit
import Foundation








let globalBackgroundColorPicker: ThemeColorPicker = ["#fff", "#595959"]
let globalTextColorPicker: ThemeColorPicker = ["#000", "#ECF0F1"]

let globalBarTextColors = ["#FFF", "#FFF"]
let globalBarTextColorPicker = ThemeColorPicker.pickerWithColors(globalBarTextColors)
let globalBarTintColorPicker: ThemeColorPicker = ["#fff", "#595959"]

//MARK: log方法
func kLog<T>(_ message: T, file: String = #file, funcName: String = #function, lineNum: Int = #line) {
    #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        print("\(fileName)---\(funcName)---\(lineNum): \(message)")
    #endif
}

//let kisLogin =
func kisLogin() -> Bool {
    let isLogin = ((UserDefaults.standard.object(forKey: "login") as? String) ?? "").characters.count > 0
    return isLogin
}
//MARK: - 列举一些常用宏
let kScreenBounds: CGRect = UIScreen.main.bounds
//屏幕size
let kScreenSize: CGSize = UIScreen.main.bounds.size
//屏幕宽度
let kScreenWidth: CGFloat = kScreenSize.width
// 屏幕的物理高度
let kScreenHeight = kScreenSize.height
//状态栏高度
let kStatusHeight = UIApplication.shared.statusBarFrame.size.height
let kNavgationHeight: CGFloat = 64.0
let kTabBarHeight: CGFloat = 50.0
let kScreenOneScale = 1.0 / UIScreen.main.scale
let kMargin: CGFloat = 10.0

// MARK: - 判断系统版本
let kSystemVersion: Float = (UIDevice.current.systemVersion as NSString).floatValue
func kiOS7Later() -> Bool { return kSystemVersion >= 7.0 }
func kiOS8Later() -> Bool { return kSystemVersion >= 8.0 }
func kiOS9Later() -> Bool { return kSystemVersion >= 9.0 }
func kiOS10Later() -> Bool { return kSystemVersion >= 10.0 }


// MARK: - 判断设备型号
func kisIPad() -> Bool { return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad; }
func kisIPhone() -> Bool { return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone; }


// MARK: - 判断屏幕物理尺寸大小
func kisCurrentModeEqualToSize(_ size: CGSize) -> Bool { return (UIScreen.instancesRespond(to: #selector(getter: UIScreen.currentMode)) ? size.equalTo(UIScreen.main.currentMode!.size) : false) }
//判断是否是iphone4 尺寸
let kisiPhone4Inch = kisCurrentModeEqualToSize(CGSize(width: 640, height: 960))

//判断是否是iphone5 尺寸
let kisiPhone5Inch = kisCurrentModeEqualToSize(CGSize(width: 640, height: 1136))

//判断是否是iphone6 尺寸
let kisiPhone6Inch = kisCurrentModeEqualToSize(CGSize(width: 750, height: 1334))

//判断是否是iphone6 Plus 尺寸
let kisiPhone6PlusInch = kisCurrentModeEqualToSize(CGSize(width: 1242, height: 2208))



// MARK: - Color
/** RGBA的颜色设置 */
func kRGBA(_ r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}
/** 0xFF0000的颜色设置 */
func kColorFromHexA(_ hex6: UInt32, alpha: CGFloat = 1) -> UIColor {
    let red     =   CGFloat((hex6 & 0xFF0000) >> 16) / 255.0
    let green   =   CGFloat((hex6 & 0x00FF00) >> 8)  / 255.0
    let blue    =   CGFloat((hex6 & 0x0000FF))       / 255.0
    return UIColor(red: red, green: green, blue: blue, alpha: alpha)
}
/** 随机颜色 */
func kRandomColor() -> UIColor {
    let randomRed = CGFloat(arc4random_uniform(256))
    let randomGreen = CGFloat(arc4random_uniform(256))
    let randomBlue = CGFloat(arc4random_uniform(256))
    return UIColor(red: randomRed/255.0, green: randomGreen/255.0, blue: randomBlue/255.0, alpha: 1.0)
}

let BGCOLOR = kRGBA(245, g: 245, b: 245, a: 1)



// MARK: - App沙盒路径
func kAppPath() -> String! {
    return NSHomeDirectory()
}
// Documents路径
func kBundleDocumentPath() -> String! {
    return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
}
// Caches路径
func kCachesPath() -> String! {
    return NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
}


//MARK： 字体
let FONT20: UIFont = UIFont(name: "PingFangSC-Regular", size: 20.0)!
let FONT18: UIFont = UIFont(name: "PingFangSC-Regular", size: 18.0)!
let FONT16: UIFont = UIFont(name: "PingFangSC-Regular", size: 16.0)!
let FONT15: UIFont = UIFont(name: "PingFangSC-Regular", size: 15.0)!
let FONT14: UIFont = UIFont(name: "PingFangSC-Regular", size: 14.0)!
let FONT13: UIFont = UIFont(name: "PingFangSC-Regular", size: 13.0)!
let FONT12: UIFont = UIFont(name: "PingFangSC-Regular", size: 12.0)!
let FONT11: UIFont = UIFont(name: "PingFangSC-Regular", size: 11.0)!
let FONT10: UIFont = UIFont(name: "PingFangSC-Regular", size: 10.0)!



/// 跳转到App设置页 >=ios8 有效
func kJumpToAppSetting() -> Bool {
    return UIApplication.shared.openURL(URL(string: UIApplicationOpenSettingsURLString)!)
}

/// 跳转到AppStore详情页
func kJumpToAppStoreDetail(appid: String) -> Bool {
    let url = "https://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=\(appid)"
    // 或者 itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=1014939463
    return UIApplication.shared.openURL(URL(string: url)!)
}

/// 跳转到AppStore评论页
func kJumpToAppStoreComment(appid: String) -> Bool {
    let url = "itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=\(appid)"
    return UIApplication.shared.openURL(URL(string: url)!)
}

/// 跳转到iTunesStore详情页
func kJumpToiTunesStore(appid: String) -> Bool {
    let url = "itms://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=\(appid)"
    return UIApplication.shared.openURL(URL(string: url)!)
}



//MARK: Load Xib
func kLoadNib(_ nibName: String!) -> AnyObject? {
    return Bundle.main.loadNibNamed(nibName, owner: nil, options: nil)?.first as AnyObject?
}

func kLoadVCFromSB(_ vc: String?, stroyBoard: String?) -> UIViewController? {
    let sb = stroyBoard == nil ? UIStoryboard(name: "Main", bundle: nil) : UIStoryboard(name: stroyBoard!, bundle: nil)
    
    if vc == nil {
        return sb.instantiateInitialViewController()
    } else {
        return sb.instantiateViewController(withIdentifier: vc!)
    }
}

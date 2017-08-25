//
//  NSString+File.swift
//  StoreDemo
//
//  Created by 赵帅 on 2017/7/7.
//  Copyright © 2017年 sun5kong. All rights reserved.
//

import UIKit

extension String {
    public func fileSize() -> UInt64 {
        var size: UInt64 = 0
        let fileManager = FileManager.default
        var isDir: ObjCBool = false
        let isExists = fileManager.fileExists(atPath: self, isDirectory: &isDir)
        if isExists {
            if isDir.boolValue {
                let enumerator = fileManager.enumerator(atPath: self)
                for subPath in enumerator! {
                    let fullPath = self.appending("/\(subPath)")
                    do {
                        let attr = try fileManager.attributesOfItem(atPath: fullPath)
                        size += attr[FileAttributeKey.size] as! UInt64
                    }catch {
                        print("error: \(error)")
                    }
                }
            } else {
                do {
                    let attr = try fileManager.attributesOfItem(atPath: self)
                    size += attr[FileAttributeKey.size] as! UInt64
                } catch  {
                    print("error: \(error)")
                }
            }
        }
        return size
    }
    
}




























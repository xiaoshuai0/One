//
//  OFPSLabel.swift
//  One-Swift
//
//  Created by 赵帅 on 2017/8/23.
//  Copyright © 2017年 sun5kong. All rights reserved.
//

import UIKit

class OFPSLabel: UILabel {

    private var _link: CADisplayLink?
    private var _count: Int = 0
    private var _lastTime: TimeInterval = 0
    private let _defaultSize = CGSize(width: 55, height: 20)
    
    override init(frame: CGRect) {
        var targetFrame = frame
        if frame.size.width == 0 && frame.size.height == 0 {
            targetFrame.size = _defaultSize
        }
        super.init(frame: targetFrame)
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        self.textAlignment = .center
        self.isUserInteractionEnabled = false
        self.textColor = UIColor.white
        self.backgroundColor = UIColor(white: 0, alpha: 0.7)
        self.font = UIFont(name: "Menlo", size: 14)
        weak var weakSelf = self
        _link = CADisplayLink(target: weakSelf!, selector: #selector(tick(link:)))
        _link?.add(to: RunLoop.main, forMode: RunLoopMode.commonModes)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tick(link: CADisplayLink) {
        if _lastTime == 0 {
            
            _lastTime = link.timestamp
            
            return
            
        }
        
        _count += 1
        
        let delta = link.timestamp - _lastTime
        
        if delta < 1 {
            
            return
            
        }
        
        _lastTime = link.timestamp
        
        let fps = Double(_count) / delta
        
        _count = 0
        
        let progress = fps / 60.0;
        
        self.textColor = UIColor(hue: CGFloat(0.27 * ( progress - 0.2 )) , saturation: 1, brightness: 0.9, alpha: 1)
        
        self.text = "\(Int(fps+0.5))FPS"
    }
}

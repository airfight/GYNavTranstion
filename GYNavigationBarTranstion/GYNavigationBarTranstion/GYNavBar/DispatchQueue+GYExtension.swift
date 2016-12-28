//
//  DispatchQueue+GYExtension.swift
//  GYNavigationBarTranstion
//
//  Created by ZGY on 2016/12/28.
//  Copyright © 2016年 GYJade. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2016/12/28  09:51
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit

public extension DispatchQueue {
    
    public static var _onceTracker = [String]()
    
    public class func once(file: String = #file, function: String = #function, line: Int = #line, block:(Void)->Void) {
        let token = file + ":" + function + ":" + String(line)
        once(token: token, block: block)
    }
    
    public class func  once(token: String, block:(Void)->Void) {
        
     objc_sync_enter(self)
        defer {
            objc_sync_exit(self)
        }
        
        if _onceTracker.contains(token) {
            return
        }
        
        _onceTracker.append(token)
        block()
        
    }
    
}

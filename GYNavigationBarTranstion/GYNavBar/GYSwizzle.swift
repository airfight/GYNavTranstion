//
//  GYSwizzle.swift
//  GYNavigationBarTranstion
//
//  Created by ZGY on 2016/12/27.
//  Copyright © 2016年 GYJade. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2016/12/27  10:07
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import Foundation
import UIKit

public func GYSwizzleMethod(cls: AnyClass,originalSelector: Selector,swizzledSelector: Selector)
{
    
       DispatchQueue.once(token: "com.gySwizzle.new") { (_) in
        
        let originalMethod = class_getInstanceMethod(cls, originalSelector)
        
        let swizzledMethod = class_getInstanceMethod(cls, swizzledSelector)
        
        let didaddMethod = class_addMethod(cls, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
        
        
        if didaddMethod {
            class_replaceMethod(cls, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
        
        
    }

}



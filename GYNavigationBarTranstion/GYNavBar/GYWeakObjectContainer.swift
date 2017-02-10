//
//  GYWeakObjectContainer.swift
//  GYNavigationBarTranstion
//
//  Created by ZGY on 2016/12/27.
//  Copyright © 2016年 GYJade. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2016/12/27  10:30
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit


class GYWeakObjectContainer: NSObject {

      weak var object:AnyObject?
   
}


public func gy_objc_setAssociatedWeakObject(container:AnyObject,key:UnsafeRawPointer?,value:AnyObject)
{
    let wrapper = GYWeakObjectContainer()
    wrapper.object = value
    print("--SET--gy_objc_getAssociatedWeakObject----")
    objc_setAssociatedObject(container, key, wrapper, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    
    
}

public func gy_objc_getAssociatedWeakObject(container: AnyObject,key:UnsafeRawPointer?) -> Any {
    print("--GET--gy_objc_getAssociatedWeakObject----")
    return objc_getAssociatedObject(container, key) as! GYWeakObjectContainer
    
    
}

    

//
//  GYNavigatiionBarTransition.swift
//  GYNavigationBarTranstion
//
//  Created by ZGY on 2016/12/27.
//  Copyright © 2016年 GYJade. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2016/12/27  13:25
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit
var kAssociatedObjectKey1:CChar = 1
//let gy_transitionContextToViewControllerKey: Void = &gy_transitionContextToViewControllerKey

extension UINavigationController {
    
    dynamic var gy_transitionContextToViewController: UIViewController?
    {
        set {
            
            if let newValue = newValue {
                gy_objc_setAssociatedWeakObject(container: self, key: GYRunTimeKey.gy_transitionContextToViewControllerKey, value: newValue)
//                 gy_objc_setAssociatedWeakObject(container: self, key:&kAssociatedObjectKey1, value: newValue)
  
            }
        }
        get {
            
            return gy_objc_getAssociatedWeakObject(container: self, key: GYRunTimeKey.gy_transitionContextToViewControllerKey) as? UIViewController
//                        return gy_objc_getAssociatedWeakObject(container: self, key: &kAssociatedObjectKey1) as? UIViewController
        }
    }
    
    func gy_containerViewBackgroundColor() -> UIColor {
        
        return UIColor.white
    }
    
    
    /// 初始化交换方法
    open override class func initialize() {
        
         DispatchQueue.once(token: "com.gybar.new") { (_) in
            
            GYSwizzleMethod(cls: object_getClass(self), originalSelector: #selector(UINavigationController.pushViewController(_:animated:)), swizzledSelector: #selector(UINavigationController.gy_pushViewController(_:animated:)))
            
            GYSwizzleMethod(cls: object_getClass(self), originalSelector: #selector(UINavigationController.popViewController(animated:)), swizzledSelector: #selector(UINavigationController.gy_popViewControllerAnimated(_:)))
            
            GYSwizzleMethod(cls: object_getClass(self), originalSelector: #selector(UINavigationController.popToViewController(_:animated:)), swizzledSelector: #selector(UINavigationController.gy_popToViewController(_:animated:)))
            
            GYSwizzleMethod(cls: object_getClass(self), originalSelector: #selector(UINavigationController.popToRootViewController(animated:)), swizzledSelector: #selector(UINavigationController.gy_popToRootViewController(_:)))
            
            GYSwizzleMethod(cls: object_getClass(self), originalSelector: #selector(UINavigationController.setViewControllers(_:animated:)), swizzledSelector: #selector(UINavigationController.gy_setViewControllers(_:animated:)))
            
        }
   
        
    }
    
    func gy_pushViewController(_ viewController:UIViewController,animated:Bool)
    {
        
        let disappearingViewController = self.viewControllers.last
        
        if !(disappearingViewController != nil) {
            return gy_pushViewController(viewController, animated: animated)
        }
        
//        guard self.gy_transitionContextToViewController != nil else {
//            return
//        }
        
        guard (self.gy_transitionContextToViewController != nil) else {
            return
        }
        
        if (self.gy_transitionContextToViewController != nil) {
        
            disappearingViewController?.gy_addTransitionNavigationBarIfNeeded()
            
        }
    
        if animated {
            self.gy_transitionContextToViewController = viewController
            
            if ((disappearingViewController?.gy_transitionNavigationBar) != nil) {
                disappearingViewController?.gy_prefersNavigationBarBackgroundViewHidden = true
            }
            
        }
        
        return self.gy_pushViewController(viewController, animated: animated)
        
    }
    
    func gy_popViewControllerAnimated(_ animated:Bool) -> UIViewController{
        
        if self.viewControllers.count < 2 {
            return gy_popViewControllerAnimated(animated)
        }
        
        let disappearingViewController = self.viewControllers.last
        
        disappearingViewController?.gy_addTransitionNavigationBarIfNeeded()
        
        let appearingViewController = self.viewControllers[self.viewControllers.count - 2]
        
        if (appearingViewController.gy_transitionNavigationBar != nil) {
            let appearingNavigationBar = appearingViewController.gy_transitionNavigationBar
            
            self.navigationBar.barTintColor = appearingNavigationBar?.barTintColor
            
            self.navigationBar.setBackgroundImage(appearingNavigationBar?.backgroundImage(for: UIBarMetrics.default), for: UIBarMetrics.default)
            
            self.navigationBar.shadowImage = appearingNavigationBar?.shadowImage
            
        }
        
        if animated {
            disappearingViewController?.gy_prefersNavigationBarBackgroundViewHidden = true
        }
        
        return gy_popViewControllerAnimated(animated)
        
    }
    
    func gy_popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]?
    {
        
        if !self.viewControllers.contains(viewController) || self.viewControllers.count < 2 {
            
            return gy_popToViewController(viewController, animated: animated)
            
        }
        
        let disappearingViewController = self.viewControllers.last
        
        disappearingViewController?.gy_addTransitionNavigationBarIfNeeded()
        
        if (viewController.gy_transitionNavigationBar != nil) {
            let appearingNavigationBar = viewController.gy_transitionNavigationBar
            self.navigationBar.barTintColor = appearingNavigationBar?.barTintColor
            self.navigationBar.setBackgroundImage(appearingNavigationBar?.backgroundImage(for: UIBarMetrics.default), for: UIBarMetrics.default)
            self.navigationBar.shadowImage = appearingNavigationBar?.shadowImage
            
        }
        
        if animated {
            disappearingViewController?.gy_prefersNavigationBarBackgroundViewHidden = true
        }
        
        return gy_popToViewController(viewController
            , animated: animated)
        
    }
    
    
    func gy_popToRootViewController(_ animated: Bool) -> [UIViewController]?
    {
     
        if self.viewControllers.count < 2 {
            return gy_popToRootViewController(animated)
        }
        
        let disappearingViewController = self.viewControllers.last
        disappearingViewController?.gy_addTransitionNavigationBarIfNeeded()
        
        let rootViewController = self.viewControllers.first
        if (rootViewController?.gy_transitionNavigationBar != nil) {
            let appearingNavigationBar = rootViewController?.gy_transitionNavigationBar
            self.navigationBar.barTintColor = appearingNavigationBar?.barTintColor
            self.navigationBar.setBackgroundImage(appearingNavigationBar?.backgroundImage(for: UIBarMetrics.default), for: UIBarMetrics.default)
            self.navigationBar.shadowImage = appearingNavigationBar?.shadowImage
            
        }
        
        if animated {
            disappearingViewController?.gy_prefersNavigationBarBackgroundViewHidden = true
        }
        
        return gy_popToRootViewController(animated)
    }
    
    func gy_setViewControllers(_ viewControllers: [UIViewController], animated: Bool)
    {
        
        let disappearingViewController = self.viewControllers.last
        
        if animated && (disappearingViewController != nil) && (disappearingViewController?.isEqual(viewControllers.last))! {
            
            disappearingViewController?.gy_addTransitionNavigationBarIfNeeded()
            
            if ((disappearingViewController?.gy_transitionNavigationBar) != nil) {
                
                disappearingViewController?.gy_prefersNavigationBarBackgroundViewHidden = true
            }
            
        }
        
        return gy_setViewControllers(viewControllers, animated: animated)
    }
    
    
}

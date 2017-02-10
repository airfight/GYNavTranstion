//
//  UIViewController+GYNavigationBarTransition.swift
//  GYNavigationBarTranstion
//
//  Created by ZGY on 2016/12/27.
//  Copyright © 2016年 GYJade. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2016/12/27  14:17
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit
let kAssociatedObjectKey:CChar = 1

public struct GYRunTimeKey {
    static let gy_transitionNavigationBarKey:UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "gy_transitionNavigationBar".hashValue)
    
    static let gy_prefersNavigationBarBackgroundViewHiddenKey:UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "gy_prefersNavigationBarBackgroundViewHiddenKey".hashValue)
    static let gy_transitionContextToViewControllerKey:UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "gy_transitionContextToViewControllerKey".hashValue)
}

extension UIViewController {
    
   dynamic var gy_transitionNavigationBar: UINavigationBar? {
        
        set {
            
            if let newValue = newValue {

              objc_setAssociatedObject(self, GYRunTimeKey.gy_transitionNavigationBarKey, newValue as UINavigationBar?, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                
            }
            
        }
        
        get {

            return objc_getAssociatedObject(self,GYRunTimeKey.gy_transitionNavigationBarKey) as? UINavigationBar
            
        }
        
    }
    
    var gy_prefersNavigationBarBackgroundViewHidden: Bool? {
        
        set {
            
            if let newValue = newValue {
                
                if self.navigationController?.navigationBar.value(forKey: "_backgroundView")  != nil {
                       (self.navigationController?.navigationBar.value(forKey: "_backgroundView") as! UIView).isHidden = newValue
                }
                
                objc_setAssociatedObject(self, GYRunTimeKey.gy_prefersNavigationBarBackgroundViewHiddenKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
            
        }
        
        get {
            
            return objc_getAssociatedObject(self,  GYRunTimeKey.gy_prefersNavigationBarBackgroundViewHiddenKey) as? Bool
            
        }
        
    }
    
    
    
    /// 此方法会多次执行
    open override class func initialize() {
        
//        DispatchQueue.once(token: "com.gyuiviewcon.new") { (_) in
//        
//            print("once")
//            GYSwizzleMethod(cls: object_getClass(self), originalSelector:#selector(UIViewController.viewWillLayoutSubviews) , swizzledSelector: #selector(UIViewController.gy_viewWillLayoutSubviews))
//            
//            GYSwizzleMethod(cls: object_getClass(self), originalSelector: #selector(UIViewController.viewDidAppear(_:)), swizzledSelector: #selector(UIViewController.gy_viewDidAppear(_:)))
//            
//        }
    
        DispatchQueue.once{
            GYSwizzleMethod(cls: object_getClass(self), originalSelector:#selector(UIViewController.viewWillLayoutSubviews) , swizzledSelector: #selector(UIViewController.gy_viewWillLayoutSubviews))
            
            GYSwizzleMethod(cls: object_getClass(self), originalSelector: #selector(UIViewController.viewDidAppear(_:)), swizzledSelector: #selector(UIViewController.gy_viewDidAppear(_:)))
        }
        
    }
    
    func gy_viewDidAppear(_ animated:Bool) {
     
        if (self.gy_transitionNavigationBar != nil) {
            navigationController?.navigationBar.barTintColor = gy_transitionNavigationBar?.barTintColor
            navigationController?.navigationBar.setBackgroundImage(self.gy_transitionNavigationBar?.backgroundImage(for: UIBarMetrics.default), for: UIBarMetrics.default)
            navigationController?.navigationBar.shadowImage = self.gy_transitionNavigationBar?.shadowImage
            
            let transitionViewController = self.navigationController?.gy_transitionContextToViewController
            
            if !(transitionViewController != nil) || (transitionViewController?.isEqual(self))! {
                
                self.gy_transitionNavigationBar?.removeFromSuperview()
                
                self.gy_transitionNavigationBar = nil
                
                self.navigationController?.gy_transitionContextToViewController = nil
                
            }
            
        }
        
        self.gy_prefersNavigationBarBackgroundViewHidden = false
        self.gy_viewDidAppear(animated)
        
    }
    
    func gy_viewWillLayoutSubviews() {
        
        let tc = self.transitionCoordinator
        
        let fromViewController = tc?.viewController(forKey: UITransitionContextViewControllerKey.from)
        
        let toViewController = tc?.viewController(forKey: UITransitionContextViewControllerKey.to)
        
        guard fromViewController != nil || toViewController != nil else {
            return
        }
        
        if self.isEqual(self.navigationController?.viewControllers.last) && (toViewController?.isEqual(self))! {
            
            if (self.navigationController?.navigationBar.isTranslucent)! {
                tc?.containerView.backgroundColor = self.navigationController?.gy_containerViewBackgroundColor();
            }
            
            fromViewController?.view.clipsToBounds = false
            toViewController?.view.clipsToBounds = false
            
            if (self.gy_transitionNavigationBar != nil) {
                self.view.bringSubview(toFront: self.gy_transitionNavigationBar!)
            }
            
            gy_viewWillLayoutSubviews()
            
        }
        
        
        
    }
    
    func gy_addTransitionNavigationBarIfNeeded(){
        
        if !self.isViewLoaded || !(self.view.window != nil) {
         
            return;
        }
        
        if !((self.navigationController?.navigationBar) != nil) {
            return;
        }
        
        gy_adjustScrollViewContentOffsetIfNeeded()
        
        /// 更改navBar状态
        let bar = UINavigationBar()
        bar.barStyle = (self.navigationController?.navigationBar.barStyle)!
        
        if bar.isTranslucent != self.navigationController?.navigationBar.isTranslucent {
            
            bar.isTranslucent = (self.navigationController?.navigationBar.isTranslucent)!
            
        }
        
        bar.barTintColor = self.navigationController?.navigationBar.barTintColor
        
        bar .setBackgroundImage(self.navigationController?.navigationBar.backgroundImage(for: UIBarMetrics.default), for: UIBarMetrics.default)
        bar.shadowImage = self.navigationController?.navigationBar.shadowImage
        
        gy_transitionNavigationBar = bar
        
        gy_resizeTransitionNavigationBarFrame()
        
        if !(self.navigationController?.isNavigationBarHidden)! && !(self.navigationController?.navigationBar.isHidden)! {
            self.view.addSubview(self.gy_transitionNavigationBar!)
        }
        
        
    }
    
    fileprivate func gy_adjustScrollViewContentOffsetIfNeeded() {
        
        if self.view.isKind(of:UIScrollView.self) {
            
            let scrollView = self.view as! UIScrollView
            let topContentOffsetY = -scrollView.contentInset.top
            let bottomContentOffsetY = -scrollView.contentSize.height - (scrollView.frame.width - scrollView.contentInset.bottom)
            
            var adjustedContentOffset = scrollView.contentOffset
            
            if adjustedContentOffset.y > bottomContentOffsetY {
                adjustedContentOffset.y = bottomContentOffsetY
            }
            
            if adjustedContentOffset.y < topContentOffsetY {
                adjustedContentOffset.y = topContentOffsetY
            }
            
            scrollView.setContentOffset(adjustedContentOffset, animated: false)
            
        }
        
    }
    
  fileprivate func gy_resizeTransitionNavigationBarFrame() {
    
    if !(self.view.window != nil) {
        return;
    }
    
    let backgroundView: UIView = self.navigationController?.navigationBar.value(forKey: "_backgroundView") as! UIView
    
    let rect = backgroundView.superview?.convert(backgroundView.frame, to: self.view)
    
    self.gy_transitionNavigationBar?.frame = rect!
    
    
    }
    
    
    
}

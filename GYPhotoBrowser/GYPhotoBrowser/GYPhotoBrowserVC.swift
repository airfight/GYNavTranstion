//
//  GYPhotoBrowserVC.swift
//  GYPhotoBrowser
//
//  Created by zhuguangyang on 16/10/10.
//  Copyright © 2016年 Giant. All rights reserved.
//

import UIKit

class GYPhotoBrowserVC: UIViewController {

    var currentIndex: Int?
    var pictureURLs: [NSURL]?
    
    
    
    init(index: Int,urls: [NSURL])
    {
        //swift语法规定，必须先初始化本类属性，在初始化父类
        currentIndex = index
        pictureURLs = urls
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        //setupUI()
    }
    
    private func setupUI() {
        
        //1.添加子控件
        view.addSubview(closeBtn)
        view.addSubview(saveBtn)
        
        //2.布局子控件
        
        closeBtn.frame = CGRect(x: 20, y: 500, width: 40, height: 20)
        saveBtn.frame = CGRect(x: 200, y: 500, width: 40, height: 20)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - 懒加载
    private lazy var closeBtn: UIButton = {
        let btn = UIButton()
        
        btn.setTitle("关闭", for: UIControlState.normal)
        btn.setTitleColor(UIColor.white, for: UIControlState.normal)
        btn.backgroundColor = UIColor.darkGray
        return btn
    }()
    
    private lazy var saveBtn: UIButton = {
        let btn = UIButton()
        
        btn.setTitle("保存", for: UIControlState.normal)
        btn.setTitleColor(UIColor.white, for: UIControlState.normal)
        btn.backgroundColor = UIColor.darkGray
        return btn
    }()

}

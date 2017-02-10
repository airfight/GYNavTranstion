//
//  ViewController.swift
//  GYNavigationBarTranstion
//
//  Created by zhuguangyang on 2016/12/27.
//  Copyright © 2016年 GYJade. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
         self.title = "ddwada"
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.white
        let backBtn = UIButton()
        
        backBtn.setImage(UIImage(named: "backBg"), for: UIControlState.normal)
        backBtn.frame = CGRect(x: 0, y: 0, width: 20, height: 30)
        backBtn.addTarget(self, action: #selector(ViewController.backAction), for: UIControlEvents.touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
        
        let view = UITableView()
        view.frame = CGRect(x: 0, y: 0, width: 200, height: 300)

        view.backgroundColor = UIColor.blue
        
        self.view.addSubview(view)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func backAction() {
        _ = navigationController?.popViewController(animated: true)
    }


}


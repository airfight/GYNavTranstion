//
//  GYVcViewController.swift
//  GYNavigationBarTranstion
//
//  Created by ZGY on 2016/12/27.
//  Copyright © 2016年 GYJade. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2016/12/27  16:50
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit

class GYVcViewController: UIViewController {
    
    //MARK: - Attributes

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "ddwada"
        let backBtn = UIButton()
        backBtn.backgroundColor = UIColor.red
        backBtn.frame = CGRect(x: 100, y: 0, width: 200, height: 100)
        backBtn.addTarget(self, action: #selector(GYVcViewController.backAction1), for: UIControlEvents.touchUpInside)
        self.view.addSubview(backBtn)
        
    }
    
    func backAction1() {
        
        self.navigationController?.pushViewController(ViewController(), animated: true)
        
    }
    
    //MARK: - Override
    
    
    //MARK: - Initial Methods
    
    
    //MARK: - Delegate
    
    
    //MARK: - Target Methods
    
    
    //MARK: - Notification Methods
    
    
    //MARK: - KVO Methods
    
    
    //MARK: - UITableViewDelegate, UITableViewDataSource
    
    
    //MARK: - Privater Methods
    
    
    //MARK: - Setter Getter Methods
    
    
    //MARK: - Life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    deinit {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

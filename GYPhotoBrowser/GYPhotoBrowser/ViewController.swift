//
//  ViewController.swift
//  GYPhotoBrowser
//
//  Created by zhuguangyang on 16/10/10.
//  Copyright © 2016年 Giant. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func localImages(_ sender: AnyObject) {
        
        let localImage = LocalImagesViewController()
        localImage.imageType = LocalImagesViewController.PhotoType.Local
        
        navigationController?.pushViewController(localImage, animated: true)
        
        
    }
    
    
    @IBAction func netWorkImages(_ sender: AnyObject) {
        
        let localImage = LocalImagesViewController()
        localImage.imageType = LocalImagesViewController.PhotoType.NetWork
        
        navigationController?.pushViewController(localImage, animated: true)
        
    }
    
    
    @IBOutlet weak var netWorkImages: UIButton!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


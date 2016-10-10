//
//  LocalImagesViewController.swift
//  GYPhotoBrowser
//
//  Created by zhuguangyang on 16/10/10.
//  Copyright © 2016年 Giant. All rights reserved.
//

import UIKit

class LocalImagesViewController: UIViewController {

    var imageType: PhotoType!
    
    var collectionVie: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        setupUI()
        
    }
    
    func setupUI() -> Void {
        
        let layOut = UICollectionViewFlowLayout()
        layOut.estimatedItemSize = CGSize(width: 40, height: 40)
        layOut.itemSize = CGSize(width: 40, height: 40)
        
        
        collectionVie = UICollectionView(frame: CGRect(x: 10, y: 150, width: Screen_Width - 20, height: Screen_Height - 300), collectionViewLayout: layOut)
//        collectionVie?.frame =
        
        collectionVie?.delegate = self
        collectionVie?.dataSource = self
        
     
        collectionVie?.collectionViewLayout = layOut
        
        
        collectionVie?.backgroundColor = UIColor.red
        view.addSubview(collectionVie!)
        
        
    }

    
    
    
    
    // MARK: - 懒加载
    ///本地图片
    lazy var localImages: [String] = {["1.jpg","2.jpg","3.jpg","4.jpg","5.jpg","6.jpg","7.jpg","8.jpg","9.jpg"]
    }()
    
    lazy var newWorkImageUrls:[String] = {
        
        return [
            "http://ios-android.cn/PB/ThumbNail/1.jpg",
            "http://ios-android.cn/PB/ThumbNail/2.jpg",
            "http://ios-android.cn/PB/ThumbNail/3.jpg",
            "http://ios-android.cn/PB/ThumbNail/4.jpg",
            "http://ios-android.cn/PB/ThumbNail/5.jpg",
            "http://ios-android.cn/PB/ThumbNail/6.jpg",
            "http://ios-android.cn/PB/ThumbNail/7.jpg",
            "http://ios-android.cn/PB/ThumbNail/8.jpg",
            "http://ios-android.cn/PB/ThumbNail/9.jpg",
                ]
        }()

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension LocalImagesViewController: UICollectionViewDataSource,UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 12
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        return UICollectionViewCell()
    }
    
    
    
    
    
    
}

extension LocalImagesViewController {
    
    enum PhotoType: Int {
        case Local = 0 ///本地图片
        
        case NetWork /// 网络图片
    }
    
}

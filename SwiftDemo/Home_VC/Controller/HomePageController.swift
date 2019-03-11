//
//  HomePageController.swift
//  SwiftDemo
//
//  Created by eyoung on 2018/9/3.
//  Copyright © 2018年 eyoung. All rights reserved.
//

import UIKit

class HomePageController: UIViewController {
    
    lazy var titleImg : UIImageView = {
        let frame = CGRect.init(x: 0, y: 151, width: 30, height: 30)
        let titleImg = UIImageView.init(frame: frame)
        titleImg.left = UIScreen.main.bounds.width-18-30
        titleImg.backgroundColor = UIColor.orange
        titleImg.layer.masksToBounds = true
        titleImg.layer.cornerRadius = 15
        return titleImg
    }()
    
    lazy var titleLbl : UILabel = {
        let frame = CGRect.init(x: 18, y: 0, width: 0, height: 25)
        let titleLbl = UILabel.init(frame: frame)
        titleLbl.width = self.titleImg.frame.origin.x-18
        titleLbl.centerY = self.titleImg.centerY
        titleLbl.font = UIFont.boldSystemFont(ofSize: 24)
        titleLbl.textColor = UIColor.colorWithString(str: "#333333")
        titleLbl.text = "测试标题".pinyinUppercase
        return titleLbl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "首页"
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(self.titleImg)
        self.view.addSubview(self.titleLbl)
        
        let alertvc = UIAlertController.init(title: "TEST", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        alertvc.addAction(UIAlertAction.init(title: "Cancel", style: UIAlertActionStyle.cancel, handler: { (param:UIAlertAction)->Void in
            
        }))
        alertvc.addAction(UIAlertAction.init(title: "OK", style: UIAlertActionStyle.default, handler: { (param:UIAlertAction)->Void in
            
        }))
        self.present(alertvc, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}

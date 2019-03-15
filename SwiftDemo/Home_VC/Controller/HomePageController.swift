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
    
    lazy var testBtn : UIButton = {
        let testButton = UIButton.init(type: UIButtonType.custom)
        testButton.frame = CGRect.init(x: 40.0, y: UIHelper.kHeight-UIHelper.safeAreaTopHeight-70.0, width: UIHelper.kWidth-80.0, height: 50.0)
        testButton.layer.cornerRadius = 5.0;
        testButton.layer.masksToBounds = true;
        testButton.backgroundColor = UIColor.colorWithString(str: "#1BABFB")
        testButton.setTitle("测试", for: UIControlState.normal)
        testButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        testButton.addTarget(self, action: #selector(testButtonAction(sender:)), for: UIControlEvents.touchUpInside)
        return testButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "首页"
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(self.titleImg)
        self.view.addSubview(self.titleLbl)
        self.view.addSubview(self.testBtn)
        
        let alertvc = UIAlertController.init(title: "TEST", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        alertvc.addAction(UIAlertAction.init(title: "Cancel", style: UIAlertActionStyle.cancel, handler: { (param:UIAlertAction)->Void in
            
        }))
        alertvc.addAction(UIAlertAction.init(title: "OK", style: UIAlertActionStyle.default, handler: { (param:UIAlertAction)->Void in
            
        }))
        self.present(alertvc, animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.showAnimation(name: "LottieLogo1")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func testButtonAction(sender: UIButton) -> Void {
        self.showAnimation(name: "celiang")
    }
    
    func showAnimation(name: String) -> Void {
        let animationView = LOTAnimationView(name: name)
        animationView.tag = 100;
        animationView.frame = CGRect.init(x: 20, y: 200, width: UIHelper.kWidth-40, height: 400)
        self.view.addSubview(animationView)
        
        weak var weakSelf = self
        animationView.play { (finished) in
            let oldAnimationView = weakSelf!.view.subviewWithTag(tag: 100)
            oldAnimationView?.removeFromSuperview()
        }
    }

}

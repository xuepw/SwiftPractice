//
//  YYHelper.swift
//  SwiftDemo
//
//  Created by eyoung on 2019/2/18.
//  Copyright © 2019年 eyoung. All rights reserved.
//

import UIKit

class YYHelper: NSObject {
    //保存服务器地址
    class func setHost(hosturl:String) -> Void {
        let serviceUrl = String.init(format: "%@%@", arguments: [hosturl, "yyyldoctor/"])
        UserDefaults.standard.setValue(serviceUrl, forKey: "YY_HostUrl")
    }
    //读取服务器地址
    class func getHost() -> String {
        return UserDefaults.standard.value(forKey: "YY_HostUrl") as! String
    }
    //标记Token过期
    class func setTokenInvalid(invalid:Bool) -> Void {
        UserDefaults.standard.set(invalid, forKey: "YY_TokenInvalid")
    }
    //读取Token是否过期
    class func getTokenInvalid() -> Bool {
        return UserDefaults.standard.bool(forKey: "YY_TokenInvalid")
    }
    //显示HUD
    class func showHUD() -> Void {
        
    }
    //取消显示HUD
    class func dismissHUD() -> Void {
        
    }
}

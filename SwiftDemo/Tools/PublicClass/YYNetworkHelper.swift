//
//  YYNetworkHelper.swift
//  SwiftDemo
//
//  Created by eyoung on 2019/2/18.
//  Copyright © 2019年 eyoung. All rights reserved.
//

import UIKit

class YYNetworkHelper: NSObject {
    let SER_SECRET = "7c01e8bd172c3133614c15ab8b49ef59"
    let APP_SECRET = "e0f3c81139d8492f6d6052acf8cbd2b8"
    let shardAFManager = AFHTTPSessionManager.init()
    
    let failedText = ""
    let HUDEThreshold = 0.69
    let successDelay = 1.0
    let timeoutInterval = 20
    static let maxRetryTimes = 3
    
    var isHUDThreshouldDisabled = false
    //这里切换测试服务器或正式服务器地址
    var theHost = YYHelper.getHost()
    
    //单例
    static let shard = YYNetworkHelper()
    
    typealias successAction = (_ response:Any?) -> ()
    typealias failedAction = (_ error:Error?) -> ()
    typealias reloginAction = () -> ()
    typealias finishedAction = (_ success:Bool) -> ()
    
    //登录过期，返回登录页
    func gotoLoginVC(relogin:@escaping reloginAction) -> Void {
        
    }
    
    //参数列表，配置系统参数
    func configParams(params:NSDictionary) -> NSDictionary {
        let paramsDic:NSMutableDictionary = NSMutableDictionary.init(dictionary: params)
        //添加必填参数：UserID、Token...
        
        //配置签名
        
        return paramsDic
    }
    
    //Functions --Base
    func request(method:String, params:NSDictionary, showHUD:Bool, reloginable:Bool, retryCount:NSInteger, successText:String, success:@escaping successAction, failed:@escaping failedAction, relogin:@escaping reloginAction, complete:@escaping finishedAction) -> Void {
        if YYHelper.getHost().isEmpty {
            NSLog("服务器地址为空，取消网络请求")
            return
        }
        if YYHelper.getTokenInvalid() {
            NSLog("Token已过期，取消网络请求")
            return
        }
        
        //配置网络请求公共参数
        let configParams = self.configParams(params: params)
        
        //0.69s后显示网络活动提示
        var isMissionCompleted = false
        let afterTime = DispatchTime(uptimeNanoseconds:UInt64((self.isHUDThreshouldDisabled ? 0 : self.HUDEThreshold)*Double(NSEC_PER_SEC)))
        DispatchQueue.main.asyncAfter(deadline: afterTime) {
            if showHUD && !isMissionCompleted {
                YYHelper.showHUD()
            }
        }
        //开始网络请求
        weak var weakSelf = self
        self.shardAFManager.requestSerializer.timeoutInterval = TimeInterval(self.timeoutInterval)
        self.shardAFManager.responseSerializer.acceptableContentTypes = ["application/json", "text/json", "text/javascript", "text/html", "text/plain"]
        self.shardAFManager.post(self.theHost, parameters: configParams, progress: nil, success: { (URLSessionDataTask, responseObj) in
            isMissionCompleted = true
            weakSelf?.isHUDThreshouldDisabled = false
            
            do {
                let jsonResult = try JSONSerialization.jsonObject(with: responseObj as! Data, options: JSONSerialization.ReadingOptions.allowFragments)
                if let responseDic = jsonResult as? NSDictionary {
                    if let code = responseDic["code"] as? Int {
                        switch code {
                        case 200:
                            DispatchQueue.main.async {
                                YYHelper.dismissHUD()
                                let responseData = responseDic["data"]
                                success(responseData)
                            }
                        case 300:
                            NSLog("[网络请求] 登录过期！")
                            //自动返回登录页
                            YYHelper.dismissHUD()
                            if reloginable {
                                weakSelf?.gotoLoginVC(relogin: relogin)
                            }
                        default:
                            //界面提示返回信息
                            YYHelper.dismissHUD()
                        }
                    }
                }
                complete(true)
            } catch {
                NSLog("[网络请求] 数据解析失败！")
                complete(true)
            }
        }) { (URLSessionDataTask, Error) in
            isMissionCompleted = true
            YYHelper.dismissHUD()
            if retryCount > 0 {
                NSLog("[网络请求] 请求失败，开始第%d次重新尝试", YYNetworkHelper.maxRetryTimes-retryCount+1)
                weakSelf?.request(method: method, params: params, showHUD: showHUD, reloginable: reloginable, retryCount: retryCount-1, successText: successText, success: success, failed: failed, relogin: relogin, complete: complete)
            } else {
                NSLog("[网络请求] 请求失败！-%@", Error.localizedDescription)
                failed(Error)
                complete(false)
            }
        }
    }
    
    //常用网络请求
    class func request(method:String, parmas:NSDictionary, showHUD:Bool, successTxt:String, success:@escaping successAction, relogin:@escaping reloginAction, failure:@escaping failedAction) -> Void {
        YYNetworkHelper.shard.request(method: method, params: parmas, showHUD: showHUD, reloginable: true, retryCount: YYNetworkHelper.maxRetryTimes, successText: successTxt, success: success, failed: failure, relogin: relogin) { (result) in }
    }
    
    //网络请求（有请求结束回调）
    class func requestWithComplete(method:String, params:NSDictionary, showHUD:Bool, successTxt:String, success:@escaping successAction, relogin:@escaping reloginAction, failure:@escaping failedAction, complete:@escaping finishedAction) -> Void {
        YYNetworkHelper.shard.request(method: method, params: params, showHUD: showHUD, reloginable: true, retryCount: YYNetworkHelper.maxRetryTimes, successText: successTxt, success: success, failed: failure, relogin: relogin, complete: complete)
    }
    
    //网络请求（不重复请求）
    class func requestWithNoRetry(method:String, parmas:NSDictionary, showHUD:Bool, successTxt:String, success:@escaping successAction, relogin:@escaping reloginAction, failure:@escaping failedAction) -> Void {
        YYNetworkHelper.shard.request(method: method, params: parmas, showHUD: showHUD, reloginable: true, retryCount: 0, successText: successTxt, success: success, failed: failure, relogin: relogin) { (result) in }
    }
    
    //网络请求（无弹出登录页）
    func requestWithUnrelogin(method:String, parmas:NSDictionary, showHUD:Bool, successTxt:String, success:@escaping successAction, relogin:@escaping reloginAction, failure:@escaping failedAction) -> Void {
        YYNetworkHelper.shard.request(method: method, params: parmas, showHUD: showHUD, reloginable: false, retryCount: YYNetworkHelper.maxRetryTimes, successText: successTxt, success: success, failed: failure, relogin: { }) { (result) in }
    }
    
}




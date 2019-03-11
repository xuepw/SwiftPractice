//
//  UIHelper.swift
//  SwiftDemo
//
//  Created by eyoung on 2019/2/15.
//  Copyright © 2019年 eyoung. All rights reserved.
//

import UIKit

class UIHelper: NSObject {
    static let kVersion = UIDevice.current.systemVersion
    static let kWidth = UIScreen.main.bounds.size.width
    static let kHeight = UIScreen.main.bounds.size.height
    static let kScale = UIHelper.kWidth/375.0
    static let safeAreaTopHeight = (UIHelper.kWidth == 812.0 || UIHelper.kWidth == 896.0) ? 88.0 : 64.0
    static let safeAreaBotHeight = (UIHelper.kWidth == 812.0 || UIHelper.kWidth == 896.0) ? 34.0 : 0.0
    
    //快速获取Label
    class func getLabel(frame:CGRect, title:NSString, font:UIFont, txtcolor:UIColor, aligment:NSTextAlignment) -> UILabel {
        let newLbl:UILabel = UILabel.init(frame: frame)
        newLbl.text = title as String
        newLbl.font = font
        newLbl.textColor = txtcolor
        newLbl.textAlignment = aligment
        return newLbl
    }
    //快速获取Button
    class func getButton(frame:CGRect, cornerRadius:CGFloat, title:NSString, font:UIFont, txtcolor:UIColor, bgcolor:UIColor) -> UIButton {
        let newBtn:UIButton = UIButton.init(frame: frame)
        newBtn.backgroundColor = bgcolor
        newBtn.layer.cornerRadius = cornerRadius
        newBtn.titleLabel?.font = font
        newBtn.setTitle(title as String, for: UIControlState.normal)
        newBtn.setTitleColor(txtcolor, for: UIControlState.normal)
        return newBtn
    }
    //快速获取TextFld
    class func getTextField(frame:CGRect, font:UIFont, txtcolor:UIColor, cornerRadius:CGFloat, placeHolder:String) -> UITextField {
        let newfield = UITextField.init(frame: frame)
        newfield.layer.cornerRadius = cornerRadius
        newfield.font = font
        newfield.textColor = txtcolor
        newfield.placeholder = placeHolder
        return newfield
    }
    //获取Layer层横线
    class func getSeperator(frame:CGRect, color:UIColor?) -> CALayer {
        let newline = CALayer.init()
        newline.frame = frame
        newline.backgroundColor = (color != nil) ? color!.cgColor : UIColor.colorWithString(str: "#E8EAED").cgColor
        return newline
    }
    //获取弹出提示框
    class func getAlertVC(title:String, cancelTitle:String, defaultTitle:String, cancelHandler:((UIAlertAction) -> Void)!, defaultHandler:((UIAlertAction) -> Void)!) -> UIAlertController {
        let newAlertVC:UIAlertController = UIAlertController.init(title: title, message: nil, preferredStyle: UIAlertControllerStyle.alert)
        let cancel = UIAlertAction.init(title: cancelTitle, style: UIAlertActionStyle.cancel, handler: cancelHandler)
        let defalut = UIAlertAction.init(title: defaultTitle, style: UIAlertActionStyle.default, handler: defaultHandler)
        newAlertVC.addAction(cancel)
        newAlertVC.addAction(defalut)
        return newAlertVC
    }
    //计算NSString尺寸
    class func getStringSize(str:NSString, boundSize:CGSize, font:UIFont) -> CGSize {
        let suitSize = str.boundingRect(with: boundSize, options: NSStringDrawingOptions(rawValue: NSStringDrawingOptions.usesLineFragmentOrigin.rawValue|NSStringDrawingOptions.usesFontLeading.rawValue|NSStringDrawingOptions.usesDeviceMetrics.rawValue), attributes: [NSAttributedStringKey.font:font], context: nil)
        return CGSize.init(width: min(suitSize.width, boundSize.width), height: suitSize.height)
    }
    //获取当前时间戳
    class func getNowTimestamp() -> NSInteger {
        let nowDouble = 1000*NSDate.init().timeIntervalSince1970
        let timeSp = NSNumber.init(value: nowDouble).intValue
        return timeSp
    }
    //时间戳转字符串 格式：YYYY-MM-dd HH:mm:ss
    class func timestampSwitchTimestr(timestamp:NSInteger) -> NSString {
        let formatter = DateFormatter.init()
        formatter.dateStyle = DateFormatter.Style.medium
        formatter.timeStyle = DateFormatter.Style.short
        //设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
        formatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        formatter.timeZone = TimeZone.init(identifier: "Asia/Beijing")
        let thedate = Date.init(timeIntervalSince1970: TimeInterval(timestamp))
        let datestr = formatter.string(from: thedate)
        return datestr as NSString
    }
    //字符串转时间戳
    class func timestrSwitchTimestamp(timestr:NSString, format:NSString) -> NSInteger {
        let formatter = DateFormatter.init()
        formatter.dateStyle = DateFormatter.Style.medium
        formatter.timeStyle = DateFormatter.Style.short
        formatter.timeZone = TimeZone.init(identifier: "Asia/Beijing")
        formatter.dateFormat = format as String
        let thedate = formatter.date(from: timestr as String)
        if thedate != nil {
            let timeSp = NSNumber.init(value: 1000*thedate!.timeIntervalSince1970).intValue
            return timeSp
        }
        return 0
    }
    //日期转字符串 字符串格式(示例：YYYY-MM-dd HH:mm:ss) hh与HH的区别:分别表示12小时制,24小时制
    class func stringFromDate(date:Date, formatterStr:String) -> String {
        let formatter = DateFormatter.init()
        formatter.dateFormat = formatterStr
        formatter.timeZone = NSTimeZone.system
        return formatter.string(from: date)
    }
    //字符串转日期
    class func dateFromString(dateStr:String, formatterStr:String) -> Date {
        let formatter = DateFormatter.init()
        formatter.dateFormat = formatterStr
        formatter.timeZone = NSTimeZone.system
        return formatter.date(from: formatterStr) ?? Date.init(timeIntervalSince1970: 0)
    }
}

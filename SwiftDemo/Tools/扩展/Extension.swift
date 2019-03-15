//
//  Extension.swift
//  SwiftDemo
//
//  Created by eyoung on 2018/9/3.
//  Copyright © 2018年 eyoung. All rights reserved.
//

import UIKit

class Extension: NSObject {

}

//MARK: - UIView扩展
extension UIView {
    var left: CGFloat {
        get {
            return self.frame.origin.x
        }
        set{
            let newOrigin = CGPoint.init(x: newValue, y: self.frame.origin.y)
            self.frame = CGRect.init(origin: newOrigin, size: self.frame.size)
        }
    }
    
    var top: CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            let newOrigin = CGPoint.init(x: self.frame.origin.x, y: newValue)
            self.frame = CGRect.init(origin: newOrigin, size: self.frame.size)
        }
    }
    
    var right: CGFloat {
        get {
            return self.frame.origin.x+self.frame.size.width
        }
        set {
            let newOrigin = CGPoint.init(x: newValue-self.frame.size.width, y: self.frame.origin.y)
            self.frame = CGRect.init(origin: newOrigin, size: self.frame.size)
        }
    }
    
    var bottom: CGFloat {
        get {
            return self.frame.origin.y+self.frame.size.height
        }
        set {
            let newOrigin = CGPoint.init(x: self.frame.origin.x, y: newValue-self.frame.size.height)
            self.frame = CGRect.init(origin: newOrigin, size: self.frame.size)
        }
    }
    
    var width: CGFloat {
        get {
            return self.frame.size.width
        }
        set {
            let newSize = CGSize.init(width: newValue, height: self.frame.size.height)
            self.frame = CGRect.init(origin: self.frame.origin, size: newSize)
        }
    }
    
    var height: CGFloat {
        get {
            return self.frame.size.height
        }
        set {
            let newSize = CGSize.init(width: self.width, height: newValue)
            self.frame = CGRect.init(origin: self.frame.origin, size: newSize)
        }
    }
    
    var centerX: CGFloat {
        get {
            return self.left+self.width/2
        }
        set {
            let newOrigin = CGPoint.init(x: newValue-self.width/2, y: self.frame.origin.y)
            self.frame = CGRect.init(origin: newOrigin, size: self.frame.size)
        }
    }
    
    var centerY: CGFloat {
        get {
            return self.top+self.height/2
        }
        set {
            let newOrigin = CGPoint.init(x: self.frame.origin.x, y: newValue-self.height/2)
            self.frame = CGRect.init(origin: newOrigin, size: self.frame.size)
        }
    }
    
    var origin: CGPoint {
        get {
            return self.frame.origin
        }
        set {
            self.frame = CGRect.init(origin: newValue, size: self.frame.size)
        }
    }
    
    var size: CGSize {
        get {
            return self.frame.size
        }
        set {
            self.frame = CGRect.init(origin: self.frame.origin, size: newValue)
        }
    }
    
    func subviewWithTag(tag: NSInteger) -> UIView? {
        for subview in self.subviews {
            if subview.tag == tag {
                return subview
            }
        }
        return nil
    }
    
}

//MARK: - UIColor扩展
extension UIColor {
    var defaultBgColor: UIColor {
        return UIColor.colorWithString(str: "#ECF0F4")
    }
    
    class func colorWithString(str:NSString) -> UIColor {
        return UIColor.colorWithString(str: str, alpha: 1.0)
    }
    
    class func colorWithString(str:NSString, alpha:CGFloat) -> UIColor {
        var formatStr = str
        if !str.hasPrefix("#") {
            formatStr = NSString.init(format: "#%@", str)
        }
        let cStr = formatStr.cString(using: String.Encoding.ascii.rawValue)!+1
        let y = strtol(cStr, nil, 16)
        return UIColor.colorWithHex(hex: y, alpha: alpha)
    }
    
    class func colorWithHex(hex:CLong, alpha:CGFloat) -> UIColor {
        let r = ((CGFloat)(hex & 0xff))/255.0
        let g = ((CGFloat)((hex >> 8) & 0xff))/255.0
        let b = ((CGFloat)((hex >> 16) & 0xff))/255.0
        return UIColor.init(red: r, green: g, blue: b, alpha: alpha)
    }
}

//MARK: - String扩展
extension String {
    var md5: String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.deallocate()
        return String(format: hash as String)
    }
    
    var pinyin: String {
        let pinyin = NSMutableString(string: self)
        //先转换成拼音
        CFStringTransform(pinyin, nil, kCFStringTransformMandarinLatin, false)
        //再去掉拼音中的注音
        CFStringTransform(pinyin, nil, kCFStringTransformStripCombiningMarks, false)
        //返回拼音字符串
        return pinyin as String
    }
    
    var pinyinUppercase: String {
        return self.pinyin.uppercased()
    }
    
}

//MARK: - NSString扩展
extension NSString {
    var noNull: NSString {
        if self.isEqual(NSNull()) {
            return ""
        }
        return self
    }
    
    var md5: NSString {
        let str: String! = self.substring(with: NSRange.init(location: 0, length: self.length))
        let strLen = CUnsignedInt(str.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.deallocate()
        return NSString(format: hash as NSString)
    }
    
    var pinyin: NSString {
        let pinyin = NSMutableString(string: self)
        //先转换成拼音
        CFStringTransform(pinyin, nil, kCFStringTransformMandarinLatin, false)
        //再去掉拼音中的注音
        CFStringTransform(pinyin, nil, kCFStringTransformStripCombiningMarks, false)
        //返回拼音字符串
        return pinyin as NSString
    }
    
    var pinyinUppercase: NSString {
        return (self.pinyin as String).uppercased() as NSString
    }
}



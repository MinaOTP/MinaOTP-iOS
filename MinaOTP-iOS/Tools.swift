//
//  Tools.swift
//  MinaOTP-iOS
//
//  Created by 武建明 on 2018/8/13.
//  Copyright © 2018年 Four_w. All rights reserved.
//

import Foundation

class Tools: NSObject {

    func totpDictionaryFormat(code: String) -> Dictionary<String, Any> {

        let url = code
        let params = NSMutableDictionary()
        if url.contains("otpauth://totp/") == false || url.contains("issuer") == false || url.contains("secret") == false{
            return params as! Dictionary<String, Any>
        }
        var index = url.index(of: "?")
        if index == nil {
            return params as! Dictionary<String, Any>
        }
        // 获取otpauth://totp/部分 并替换为remark
        let otpauth = url.prefix(upTo: index!)
        let otpauthIndx = otpauth.index(otpauth.startIndex, offsetBy: "otpauth://totp/".count)
        let remark = otpauth.suffix(from: Optional.init(otpauthIndx)!)
        params.setValue(remark, forKey: "remark")
        // 获取问号后面部分的字符串
        index = url.index(index!, offsetBy: 1)
        let parametersString = url.suffix(from: index!)
        // 解析参数
        let urlComponents = parametersString.components(separatedBy: "&")
        for keyValuePair in urlComponents {
            let pairComponents = keyValuePair.components(separatedBy: "=")
            let key = pairComponents.first
            let value = pairComponents.last
            if key == nil || value == nil {
                continue
            }
            params.setValue(value, forKey: key!)
        }
        return params as! Dictionary<String, Any>
    }

    func totpStringFormat(remark: String, issuer:String, secret:String) -> String {
        return "otpauth://totp/\(remark)?secret=\(secret)&issuer=\(issuer)"
    }
}

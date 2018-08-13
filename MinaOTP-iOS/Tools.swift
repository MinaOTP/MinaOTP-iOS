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
        var replaceStr = code
        let breakWords = ["otpauth://totp/", "?secret=", "&issuer="]
        for word in breakWords{
            replaceStr = replaceStr.replacingOccurrences(of: word, with: "#break_words#")
        }
        let resultArray = replaceStr.components(separatedBy: "#break_words#")
        let resultDic = ["remark": resultArray[1], "secret": resultArray[2], "issuer": resultArray[3]]
        return resultDic
    }

    func totpStringFormat(remark: String, issuer:String, secret:String) -> String {
        return "otpauth://totp/\(remark)?secret=\(secret)&issuer=\(issuer)"
    }
}

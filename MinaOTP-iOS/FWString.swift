//
//  FWString.swift
//  Mina_OTP_SWIFT
//
//  Created by 武建明 on 2018/4/11.
//  Copyright © 2018年 Four_w. All rights reserved.
//

import Foundation

extension String {
    public func substring(from index: Int) -> String {
        if self.count > index {
            let startIndex = self.index(self.startIndex, offsetBy: index)
            let subString = self[startIndex..<self.endIndex]
            return String(subString)
        } else {
            return self
        }
    }
    public func substring(to index: Int) -> String {
        if self.count > index {
            let endindex = self.index(self.startIndex, offsetBy: index)
            let subString = self[self.startIndex..<endindex]
            return String(subString)
        } else {
            return self
        }
    }
}

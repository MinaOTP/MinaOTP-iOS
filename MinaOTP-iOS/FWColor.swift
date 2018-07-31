//
//  FWColor.swift
//  Mina_OTP_SWIFT
//
//  Created by 武建明 on 2018/4/11.
//  Copyright © 2018年 Four_w. All rights reserved.
//

import UIKit

extension UIColor{
    class func baseTextColor() ->UIColor{
        return UIColor.black
    }

    /// 灰色背景色
    ///
    /// - Returns:灰色背景色,白色底色的分割线
    class func lineGrayColor() ->UIColor{
        return UIColor.colorWithHexString(hex: "EEEEEE")
    }

    /// 黑色背景
    ///
    /// - Returns: 返回黑色背景
    class func blackBackColor() ->UIColor{
        return UIColor.colorWithHexString(hex: "0D0D0D")
    }
    /// cell浅黑色背景
    ///
    /// - Returns: 返回cell浅黑色背景
    class func cellBackColor() ->UIColor{
        return UIColor.colorWithHexString(hex: "191919")
    }
    /// 默认橘色字体
    ///
    /// - Returns: 默认橘色字体
    class func textOrangeColor() ->UIColor{
        return UIColor.colorWithHexString(hex: "FF7D27")
    }
    /// 灰色线
    ///
    /// - Returns:白色底色的分割线
    class func lineColor() ->UIColor{
        return UIColor.colorWithHexString(hex: "2E2E2E")
    }

    /// 默认黑色字体
    ///
    /// - Returns: 默认黑色字体
    class func textBlackColor() ->UIColor{
        return UIColor.colorWithHexString(hex: "333333")
    }

    /// 高亮灰色
    ///
    /// - Returns: 高亮灰色
    class func textLightGrayColor() ->UIColor{
        return UIColor.colorWithHexString(hex: "696969")
    }


    class func colorWithHexString(hex: String) ->UIColor {
        var cString = hex.trimmingCharacters(in:CharacterSet.whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) {
            cString = cString.substring(from: 1)
        }
        if (cString.count != 6){
            return UIColor.red
        }
        let rString = cString.substring(to:2)
        let otherString = cString.substring(from:2)
        let gString = otherString.substring(to:2)
        let bString = otherString.substring(from:2)
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }

}


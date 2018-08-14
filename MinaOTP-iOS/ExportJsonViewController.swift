//
//  ExportJsonViewController.swift
//  MinaOTP-iOS
//
//  Created by 武建明 on 2018/8/14.
//  Copyright © 2018年 Four_w. All rights reserved.
//

import UIKit
import PKHUD

class ExportJsonViewController: UIViewController{

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    struct OtpModel:Codable {
        var secret:String
        var issuer:String
        var remark:String
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Copy Json"
        self.view.backgroundColor = UIColor.blackBackColor()
        self.view.addSubview(self.bgView)
        self.bgView.addSubview(self.jsonTextView)

        self.navigationItem.leftBarButtonItem?.setTitlePositionAdjustment(UIOffset.init(horizontal: 0, vertical: 0), for: .default)
        let rightBarButtonItem = UIBarButtonItem(title: "Copy", style: .plain, target: self, action: #selector(rightItemAction))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem

        let defaults = UserDefaults.standard
        let allItems  = defaults.value(forKey: "MinaOtp") as? [String] ?? []
        var temArray = [Any]()
        for item in allItems{
            let otpDic = Tools().totpDictionaryFormat(code: item)
            temArray.append(otpDic)
        }
        let temJsonData = try! JSONSerialization.data(withJSONObject: temArray, options: .prettyPrinted)
        let temJsonStr = String.init(data: temJsonData, encoding: .utf8)
        jsonTextView.text = temJsonStr
    }
    lazy var bgView: UIView = {
        let view = UIView.init(frame: CGRect(x: 0, y:0 , width: KScreenW, height: KScreenH))
        view.backgroundColor = UIColor.cellBackColor()
        return view
    }()
    lazy var jsonTextView: UITextView = {
        let textView = UITextView.init(frame: CGRect(x: 12, y: 12, width: KScreenW-24, height: KScreenH-24-64))
        textView.textColor = UIColor.white
        textView.backgroundColor = UIColor.cellBackColor()
        textView.font = UIFont.systemFont(ofSize: 12)
        textView.returnKeyType = .done
        textView.tintColor = UIColor.textOrangeColor()
        textView.isPagingEnabled = false
        textView.isEditable = false
        textView.isSelectable = false
        return textView
    }()

    @objc func rightItemAction(sender:UIBarButtonItem){
        print(jsonTextView.text)
        UIPasteboard.general.string = jsonTextView.text
        HUD.flash(.labeledSuccess(title: "复制成功", subtitle: nil), delay: 0.5)
    }
}

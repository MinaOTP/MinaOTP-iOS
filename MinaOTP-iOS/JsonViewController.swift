//
//  JsonViewController.swift
//  MinaOTP-iOS
//
//  Created by 武建明 on 2018/8/14.
//  Copyright © 2018年 Four_w. All rights reserved.
//

import UIKit
import PKHUD

class JsonViewController: UIViewController, UITextViewDelegate{

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
        self.navigationItem.title = "Import Json"
        self.view.backgroundColor = UIColor.blackBackColor()
        self.view.addSubview(self.bgView)
//        self.bgView.addSubview(self.titleLabel)
        self.bgView.addSubview(self.jsonTextView)

        self.navigationItem.leftBarButtonItem?.setTitlePositionAdjustment(UIOffset.init(horizontal: 0, vertical: 0), for: .default)
        let rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(rightItemAction))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        self.navigationItem.rightBarButtonItem?.isEnabled = false

        let allItems  = ["otpauth://totp/gitLab?secret=uaeofeh7kcwbu35zm&issuer=gitlab.com", "otpauth://totp/账号?secret=vuswu4la5mny&issuer=me.com"]
        var temArray = [Any]()
        for item in allItems{
            let otpDic = Tools().totpDictionaryFormat(code: item)
            temArray.append(otpDic)
        }
        let temJsonData = try! JSONSerialization.data(withJSONObject: temArray, options: .prettyPrinted)
        let temJsonStr = String.init(data: temJsonData, encoding: .utf8)
        jsonTextView.placeholder = "example:\n\n"+temJsonStr!
    }
    lazy var bgView: UIView = {
        let view = UIView.init(frame: CGRect(x: 0, y:0 , width: KScreenW, height: KScreenH))
        view.backgroundColor = UIColor.cellBackColor()
        return view
    }()
    lazy var jsonTextView: UITextView = {
        let textView = UITextView.init(frame: CGRect(x: 12, y: 12, width: KScreenW-24, height: KScreenH-24-64))
        textView.delegate = self
        textView.textColor = UIColor.white
        textView.backgroundColor = UIColor.cellBackColor()
        textView.font = UIFont.systemFont(ofSize: 12)
        textView.returnKeyType = .done
        textView.tintColor = UIColor.textOrangeColor()
        textView.placeholder = "请输入json格式:"
        return textView
    }()

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if jsonTextView.isFirstResponder {
            jsonTextView.resignFirstResponder()
        }
    }
    func textViewDidChange(_ textView: UITextView) {
        self.navigationItem.rightBarButtonItem?.isEnabled = textView.text.count>0
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            jsonTextView.resignFirstResponder()
            return false
        }
        return true
    }
    @objc func rightItemAction(sender:UIBarButtonItem){

        let decoder = JSONDecoder()
        do {
            let otpModelArray = try decoder.decode([OtpModel].self, from: jsonTextView.text.data(using: .utf8)!)
            // 将数据保存到UserDefaults
            let defaults = UserDefaults.standard
            var allItems  = defaults.value(forKey: "MinaOtp") as? [String] ?? []
            for item in otpModelArray{
                let otp = Tools().totpStringFormat(remark: item.remark, issuer: item.issuer, secret: item.secret)
                allItems.append(otp)
            }
            defaults.set(allItems, forKey: "MinaOtp")
            HUD.flash(.labeledSuccess(title: "导入成功", subtitle: nil), delay: 1)
            self.navigationController?.popViewController(animated: true)
        } catch let error{
            print(error)
            HUD.flash(.labeledError(title: "导入的内容格式不正确", subtitle: nil), delay: 1)
        }
    }
}

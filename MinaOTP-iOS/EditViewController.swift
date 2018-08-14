//
//  EditViewController.swift
//  MinaOTP-iOS
//
//  Created by 武建明 on 2018/8/13.
//  Copyright © 2018年 Four_w. All rights reserved.
//

import UIKit
import PKHUD

class EditViewController: UIViewController, UITextFieldDelegate{

    var editRow = -1

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Manual entry"
        self.view.backgroundColor = UIColor.blackBackColor()
        self.view.addSubview(self.remarkBgView)
        self.remarkBgView.addSubview(self.remarkTitleLabel)
        self.remarkBgView.addSubview(self.remarkTextField)
        self.view.addSubview(self.issuerBgView)
        self.issuerBgView.addSubview(self.issuerTitleLabel)
        self.issuerBgView.addSubview(self.issuerTextField)
        self.view.addSubview(self.secretBgView)
        self.secretBgView.addSubview(self.secretTitleLabel)
        self.secretBgView.addSubview(self.secretTextFiled)

        self.navigationItem.leftBarButtonItem?.setTitlePositionAdjustment(UIOffset.init(horizontal: 0, vertical: 0), for: .default)
        let rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(rightItemAction))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        self.navigationItem.rightBarButtonItem?.isEnabled = false
    }
    lazy var remarkBgView: UIView = {
        let view = UIView.init(frame: CGRect(x: 0, y:0 , width: KScreenW, height: 80))
        view.backgroundColor = UIColor.cellBackColor()
        return view
    }()
    lazy var remarkTitleLabel: UILabel = {
        let lab = UILabel.init(frame: CGRect(x: 12, y:0 , width: 200, height: 30))
        lab.text = "请输入remark:"
        lab.textColor = UIColor.white
        lab.font = UIFont.systemFont(ofSize: 12)
        return lab
    }()
    lazy var remarkTextField: UITextField = {
        let textField = UITextField.init(frame: CGRect(x: 12, y: 30, width: KScreenW-24, height: 40))
        textField.delegate = self
        textField.textColor = UIColor.white
        textField.font = UIFont.systemFont(ofSize: 12)
        textField.returnKeyType = .done
        textField.tintColor = UIColor.textOrangeColor()
        textField.addTarget(self, action: #selector(textFieldTextChanged), for: .editingChanged)

        var line = CALayer.init()
        line.frame = CGRect(x: 0, y: textField.frame.size.height, width: textField.frame.size.width, height: 1)
        line.backgroundColor = UIColor.lineColor().cgColor
        textField.layer.addSublayer(line)
        return textField
    }()
    lazy var issuerBgView: UIView = {
        let view = UIView.init(frame: CGRect(x: 0, y:remarkBgView.frame.origin.y+remarkBgView.frame.size.height, width: KScreenW, height: 80))
        view.backgroundColor = UIColor.cellBackColor()
        return view
    }()
    lazy var issuerTitleLabel: UILabel = {
        let lab = UILabel.init(frame: CGRect(x: 12, y:0 , width: 200, height: 30))
        lab.text = "请输入issuer:"
        lab.textColor = UIColor.white
        lab.font = UIFont.systemFont(ofSize: 12)
        return lab
    }()
    lazy var issuerTextField: UITextField = {
        let textField = UITextField.init(frame: CGRect(x: 12, y: 30, width: KScreenW-24, height: 40))
        textField.delegate = self
        textField.textColor = UIColor.white
        textField.font = UIFont.systemFont(ofSize: 12)
        textField.returnKeyType = .done
        textField.tintColor = UIColor.textOrangeColor()
        textField.addTarget(self, action: #selector(textFieldTextChanged), for: .editingChanged)

        var line = CALayer.init()
        line.frame = CGRect(x: 0, y: textField.frame.size.height, width: textField.frame.size.width, height: 1)
        line.backgroundColor = UIColor.lineColor().cgColor
        textField.layer.addSublayer(line)
        return textField
    }()
    lazy var secretBgView: UIView = {
        let view = UIView.init(frame: CGRect(x: 0, y:issuerBgView.frame.origin.y+issuerBgView.frame.size.height , width: KScreenW, height: 80))
        view.backgroundColor = UIColor.cellBackColor()
        return view
    }()
    lazy var secretTitleLabel: UILabel = {
        let lab = UILabel.init(frame: CGRect(x: 12, y:0 , width: 200, height: 30))
        lab.text = "请输入secret:"
        lab.textColor = UIColor.white
        lab.font = UIFont.systemFont(ofSize: 12)
        return lab
    }()
    lazy var secretTextFiled: UITextField = {
        let textField = UITextField.init(frame: CGRect(x: 12, y: 30, width: KScreenW-24, height: 40))
        textField.delegate = self
        textField.textColor = UIColor.white
        textField.font = UIFont.systemFont(ofSize: 12)
        textField.returnKeyType = .done
        textField.tintColor = UIColor.textOrangeColor()
        textField.addTarget(self, action: #selector(textFieldTextChanged), for: .editingChanged)

        var line = CALayer.init()
        line.frame = CGRect(x: 0, y: textField.frame.size.height, width: textField.frame.size.width, height: 1)
        line.backgroundColor = UIColor.lineColor().cgColor
        textField.layer.addSublayer(line)
        return textField
    }()

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if remarkTextField.isFirstResponder {
            remarkTextField.resignFirstResponder()
        }
        if issuerTextField.isFirstResponder {
            issuerTextField.resignFirstResponder()
        }
        if secretTextFiled.isFirstResponder {
            secretTextFiled.resignFirstResponder()
        }
    }
    @objc func textFieldTextChanged(){
        if self.remarkTextField.text?.count == 0 || self.issuerTextField.text?.count == 0 || self.secretTextFiled.text?.count == 0{
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        }else{
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    @objc func rightItemAction(sender:UIBarButtonItem){

        let totp = Tools().totpStringFormat(remark: remarkTextField.text!, issuer: issuerTextField.text!, secret: secretTextFiled.text!)
        // 将数据保存到UserDefaults
        let defaults = UserDefaults.standard
        var allItems  = defaults.value(forKey: "MinaOtp") as? [String] ?? []

        if editRow < 0 {
            allItems.append(totp)
        }else{
            allItems.remove(at: editRow)
            allItems.insert(totp, at: editRow)
        }
        defaults.set(allItems, forKey: "MinaOtp")
        HUD.flash(.success, delay: 1)
        self.navigationController?.popViewController(animated: true)
    }
}

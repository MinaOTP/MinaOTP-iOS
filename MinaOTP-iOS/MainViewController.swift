//
//  MainViewController.swift
//  Mina_OTP_SWIFT
//
//  Created by 武建明 on 2018/4/11.
//  Copyright © 2018年 Four_w. All rights reserved.
//

import UIKit
import PKHUD

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var totpArray = [String]()
    var oldTimeStamp = 0

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        totpArray.removeAll()
        totpArray = DataManager.get()
        totpTableView.reloadData()
        self.startTimer()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.stopTimer()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "MinaOTP"
        self.view.backgroundColor = UIColor.blackBackColor()

        let rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(rightItemAction))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem

        let leftBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(leftItemAction))
        self.navigationItem.leftBarButtonItem = leftBarButtonItem

        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.cellBackColor()
        self.navigationController?.navigationBar.tintColor = UIColor.textOrangeColor()

        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedStringKey.foregroundColor: UIColor.white
        ]

        self.view.addSubview(self.totpTableView)
        self.view.addSubview(self.progressView)
        
        DataManager.initial { [weak self] in
            self?.totpArray.removeAll()
            self?.totpArray = DataManager.get()
            self?.totpTableView.reloadData()
        }
    }
    lazy var progressView:UIProgressView = {
        let view = UIProgressView(progressViewStyle: .bar)
        view.frame = CGRect(x: 0, y: 0, width: KScreenW, height: 0)
        view.backgroundColor = UIColor.cellBackColor()
        view.progressTintColor = UIColor.textOrangeColor()
        view.progress=0
        return view
    }()

    lazy var totpTableView:UITableView = {
        let tab = UITableView(frame: CGRect(x: 0, y: 0, width: KScreenW, height: KScreenH-self.navBarBottom), style: .grouped)
        tab.delegate = self;
        tab.dataSource = self;
        tab.backgroundColor = UIColor.blackBackColor()
        tab.separatorStyle = .singleLine
        tab.separatorColor = UIColor.lineColor()
        tab.allowsSelectionDuringEditing = true
        if #available(iOS 11.0, *) {
            tab.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        return tab
    }()

    lazy var timer:Timer! = {
        let t = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        RunLoop.main.add(t, forMode: .commonModes)
        return t
    }()

    lazy var navBarBottom:CGFloat = {
        return CGFloat(self.navigationController!.navigationBar.frame.origin.y) + CGFloat(self.navigationController!.navigationBar.frame.size.height)
    }()

    func startTimer() {
        self.totpTableView.reloadData()
        oldTimeStamp = Int(Date().timeIntervalSince1970)/30
        self.progressView.isHidden = false
        self.timer.fireDate = Date.distantPast
    }

    func stopTimer() {
        self.totpTableView.reloadData()
        self.progressView.isHidden = true
        self.timer.fireDate = Date.distantFuture
    }
    @objc func timerAction() {
        let nowTimeStamp = Int(Date().timeIntervalSince1970)/30
        let progress = Date().timeIntervalSince1970/30-Double(nowTimeStamp)
        self.progressView.setProgress(Float(progress), animated: true)
        if nowTimeStamp != self.oldTimeStamp{
            self.totpTableView.reloadData()
            self.oldTimeStamp = nowTimeStamp
        }
    }
    

    @objc func rightItemAction(sender:UIBarButtonItem){

        if self.navigationItem.rightBarButtonItem?.title == "Export" {
            self.navigationItem.leftBarButtonItem?.title = "Edit"
            self.navigationItem.rightBarButtonItem?.title = "Add"
            self.totpTableView.setEditing(false, animated: false)
            self.navigationController?.pushViewController(ExportJsonViewController(), animated: true)
            return
        }
        let aletVC = UIAlertController.init(title: "Add Two-factor Authentication", message: nil, preferredStyle: .actionSheet)
        aletVC.addAction(UIAlertAction.init(title: "Scan Qr Code", style: .default, handler: { (action) in
            self.navigationController?.pushViewController(AddSecretViewController(), animated: true)
        }))
        aletVC.addAction(UIAlertAction.init(title: "Manual entry", style: .default, handler: { (action) in
            self.navigationController?.pushViewController(EditViewController(), animated: true)
        }))
        aletVC.addAction(UIAlertAction.init(title: "Import Json", style: .default, handler: { (action) in
            self.navigationController?.pushViewController(JsonViewController(), animated: true)
        }))
        aletVC.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: { (action) in

        }))
        self.present(aletVC, animated: true) {
            self.navigationItem.leftBarButtonItem?.title = "Edit"
            self.navigationItem.rightBarButtonItem?.title = "Add"
            self.totpTableView.setEditing(false, animated: false)
        }
    }

    @objc func leftItemAction(sender:UIBarButtonItem){
        if self.totpTableView.isEditing {
            self.navigationItem.leftBarButtonItem?.title = "Edit"
            self.navigationItem.rightBarButtonItem?.title = "Add"
        }else{
            self.navigationItem.leftBarButtonItem?.title = "Done"
            self.navigationItem.rightBarButtonItem?.title = "Export"
        }
        self.totpTableView.setEditing(!self.totpTableView.isEditing, animated: true)
        self.totpTableView.isEditing ? self.stopTimer() : self.startTimer()
    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kCellHeight
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.2
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return totpArray.count
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.totpArray.remove(at: indexPath.row)
            self.totpTableView.deleteRows(at: [indexPath], with: .left)
            DataManager.save(self.totpArray)
        }else{
            print("not delete")
        }
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = totpArray[sourceIndexPath.row]
        totpArray.remove(at: sourceIndexPath.row)
        totpArray.insert(item, at: destinationIndexPath.row)
        DataManager.save(self.totpArray)
    }
    func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        print("编辑结束")
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:CodeTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "CodeTableViewCell") as? CodeTableViewCell
        if (cell == nil){
            cell = CodeTableViewCell(style: .subtitle,
                                   reuseIdentifier: "CodeTableViewCell")
        }

        let totpDic = Tools().totpDictionaryFormat(code: totpArray[indexPath.row])
        cell!.otpauthLabel.text = totpDic["remark"] as? String
        cell!.issuerLabel.text = totpDic["issuer"] as? String
        cell!.secretLabel.text = self.totpTableView.isEditing ? "" : GeneratorTotp.generateOTP(forSecret: totpDic["secret"] as? String)

        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)

        let totpDic = Tools().totpDictionaryFormat(code: totpArray[indexPath.row])

        if totpTableView.isEditing {
            self.navigationItem.leftBarButtonItem?.title = "Edit"
            self.navigationItem.rightBarButtonItem?.title = "Add"
            totpTableView.setEditing(false, animated: true)
            let editVc = EditViewController()
            editVc.editRow = indexPath.row
            editVc.remarkTextField.text = totpDic["remark"] as? String
            editVc.issuerTextField.text = totpDic["issuer"] as? String
            editVc.secretTextFiled.text = totpDic["secret"] as? String
            self.navigationController?.pushViewController(editVc, animated: true)
        }else{
            UIPasteboard.general.string = GeneratorTotp.generateOTP(forSecret: totpDic["secret"] as? String)
            HUD.flash(.labeledSuccess(title: "复制成功", subtitle: nil), delay: 0.5)
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

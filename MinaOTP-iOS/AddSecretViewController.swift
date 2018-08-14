//
//  AddSecretViewController.swift
//  Mina_OTP_SWIFT
//
//  Created by 武建明 on 2018/4/12.
//  Copyright © 2018年 Four_w. All rights reserved.
//

import UIKit
import AVFoundation
import PKHUD

class AddSecretViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    //    扫描二维码所需要的属性
    //    输入对象  图像捕捉对象，用来捕捉相应的元素7 23763 23173 2
    private lazy var input : AVCaptureDeviceInput? = nil
    //    MARK:  懒加载
    //    输出对象
    let qrViewWeight = CGFloat(280)
    let qrViewHeight = CGFloat(280)/4*3

    weak var delegate : AddSecretViewControllerDelegate?

    private lazy var output : AVCaptureMetadataOutput = {

        let out = AVCaptureMetadataOutput()
        let rect = self.view.frame
        let containerRect = CGRect(x: (KScreenW-qrViewWeight)/2, y: 80, width: qrViewWeight, height: qrViewHeight)

        let x = containerRect.origin.y / rect.height
        let y = containerRect.origin.x / rect.width
        let w = containerRect.height / rect.height
        let h = containerRect.width / rect.width

        out.rectOfInterest = CGRect(x: x, y: y, width: w, height: h)
        return out
    }()

    lazy var navBarBottom:CGFloat = {
        return CGFloat(self.navigationController!.navigationBar.frame.origin.y) + CGFloat(self.navigationController!.navigationBar.frame.size.height)
    }()

    //    回话层对象
    private lazy var session : AVCaptureSession = AVCaptureSession()
    //    预览图层
    lazy var previewLayer : AVCaptureVideoPreviewLayer = {
        let previewLayer : AVCaptureVideoPreviewLayer =  AVCaptureVideoPreviewLayer(session: self.session)
        return previewLayer
    }()
    // 遮盖图层
    lazy var maskView : UIView = {
        let maskView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: KScreenW, height: KScreenH-navBarBottom))
        maskView.backgroundColor = UIColor.clear
        let bezierPath : UIBezierPath = UIBezierPath(roundedRect: maskView.bounds, cornerRadius: 0)
        let hollowPath : UIBezierPath = UIBezierPath(roundedRect: CGRect(x: (KScreenW-qrViewWeight)/2, y: 40, width: qrViewWeight, height: qrViewHeight), cornerRadius: 8)
        bezierPath.append(hollowPath)
        bezierPath.usesEvenOddFillRule = true

        let fillLayer = CAShapeLayer()
        fillLayer.path = bezierPath.cgPath
        fillLayer.fillRule = kCAFillRuleEvenOdd
        fillLayer.fillColor = UIColor.blackBackColor().cgColor
        fillLayer.opacity = 1
        maskView.layer.addSublayer(fillLayer)
        return maskView
    }()

    lazy var tipLable : UILabel = {
        let label = UILabel(frame: CGRect(x: 20, y: navBarBottom, width: KScreenW-40, height: 30))

        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Scan Qr Code"
        self.view.backgroundColor = UIColor.blackBackColor()
        // Do any additional setup after loading the view.
//        let leftBarItem = UIBarButtonItem(title: "返回", style: .done, target: self, action: #selector(self.returnAction))
//        self.navigationItem.leftBarButtonItem = leftBarItem
        scanQRCode()
        self.view.addSubview(maskView)
    }
    //    扫描二维码
    func scanQRCode() -> () {

        //       对懒加载的input进行赋值
        guard let device = AVCaptureDevice.default(for: .video) else {
            return
        }
        input = try? AVCaptureDeviceInput.init(device: device)

        //        1.判断是否能加入输入
        if !session.canAddInput(input!) {
            return
        }
        //        2.判断是否能加入输出
        if !session.canAddOutput(output) {
            return
        }
        //        3.加入输入和输出
        session.addInput(input!)
        session.addOutput(output)
        //        4.设置输出能够解析的数据类型
        output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        //        5.设置监听监听解析到的数据类型
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        //        6.添加预览图层
        view.layer.insertSublayer(previewLayer, at: 0)
        previewLayer.frame = view.bounds
        //        7.开始扫描
        session.startRunning()
    }
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection){
        session.stopRunning()
        //        1.获取到文字信息
        if let metatdataObject = metadataObjects.first {
            guard let readableObject = metatdataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            otpFormat(code: stringValue)
        }
        dismiss(animated: true)
    }
    func otpFormat(code: String) {
        if code.contains("otpauth://totp/") == false || code.contains("?secret=") == false || code.contains("&issuer=") == false{
            session.startRunning()
            return
        }
        let defaults = UserDefaults.standard
        var allItems  = defaults.value(forKey: "MinaOtp") as? [String] ?? []
        allItems.append(code)
        defaults.set(allItems, forKey: "MinaOtp")
        HUD.flash(.success, delay: 1)
        self.navigationController?.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

protocol AddSecretViewControllerDelegate: class {
    func scanSuccess(code: String)
}


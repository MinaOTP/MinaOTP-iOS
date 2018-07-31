//
//  CodeTableViewCell.swift
//  Mina_OTP_SWIFT
//
//  Created by 武建明 on 2018/4/13.
//  Copyright © 2018年 Four_w. All rights reserved.
//

import UIKit
import SnapKit

class CodeTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addViews()
        self.backgroundColor = UIColor.cellBackColor()
        self.contentView.backgroundColor = UIColor.cellBackColor()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//    override func draw(_ rect: CGRect) {
//        let cxt = UIGraphicsGetCurrentContext();
//        cxt?.setLineWidth(0.5)
//        cxt?.setStrokeColor(UIColor.lineColor().cgColor)
//        cxt?.move(to: CGPoint(x: KScreenW/4, y: self.frame.size.height-0.3))
//        cxt?.addLine(to: CGPoint(x: KScreenW/4*3, y: self.frame.size.height-0.3))
//        cxt?.strokePath()
//    }
    func addViews(){
        self.contentView.addSubview(self.issuerLabel)
        self.issuerLabel.snp.makeConstraints { (make) in
            make.width.equalTo(KScreenW/3*2)
            make.left.equalTo(12)
            make.height.equalTo(kCellHeight/2)
            make.top.equalTo(0)
        }
        self.contentView.addSubview(self.secretLabel)
        self.secretLabel.snp.makeConstraints { (make) in
            make.right.equalTo(0)
            make.left.equalTo(self.issuerLabel.snp.right)
            make.height.equalTo(kCellHeight)
            make.top.equalTo(0)
        }

        self.contentView.addSubview(self.otpauthLabel)
        self.otpauthLabel.snp.makeConstraints { (make) in
            make.width.equalTo(KScreenW/3*2)
            make.left.equalTo(12)
            make.height.equalTo(kCellHeight/2)
            make.top.equalTo(self.issuerLabel.snp.bottom)
        }
    }

    lazy var secretLabel: UILabel = {
        let lab = UILabel()
        lab.text = ""
        lab.textColor = UIColor.white
        lab.font = UIFont.systemFont(ofSize: 24)
        lab.textAlignment = .center
        return lab
    }()

    lazy var issuerLabel: UILabel = {
        let lab = UILabel()
        lab.text = ""
        lab.textColor = UIColor.white
        lab.font = UIFont.systemFont(ofSize: 15)
        lab.textAlignment = .left
        lab.adjustsFontSizeToFitWidth = true
        return lab
    }()

    lazy var otpauthLabel: UILabel = {
        let lab = UILabel()
        lab.text = ""
        lab.textColor = UIColor.white
        lab.font = UIFont.systemFont(ofSize: 14)
        lab.textAlignment = .left
        lab.adjustsFontSizeToFitWidth = true
        return lab
    }()

    lazy var timeButton: UIButton = {
        let btn = UIButton(frame: CGRect(x: 20, y: 0, width: 100, height: kCellHeight))
        btn.setTitle("时间", for: .normal)
        btn.setTitleColor(UIColor.red, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        return btn
    }()

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

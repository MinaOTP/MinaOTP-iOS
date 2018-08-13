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
    func addViews(){

        self.contentView.addSubview(self.otpauthLabel)
        self.otpauthLabel.snp.makeConstraints { (make) in
            make.width.equalTo(KScreenW/3*2)
            make.left.equalTo(12)
            make.height.equalTo(kCellHeight/2)
            make.top.equalTo(0)
        }
        self.contentView.addSubview(self.issuerLabel)
        self.issuerLabel.snp.makeConstraints { (make) in
            make.width.equalTo(KScreenW/3*2)
            make.left.equalTo(12)
            make.height.equalTo(kCellHeight/2)
            make.top.equalTo(self.otpauthLabel.snp.bottom)
        }
        self.contentView.addSubview(self.secretLabel)
        self.secretLabel.snp.makeConstraints { (make) in
            make.right.equalTo(0)
            make.left.equalTo(self.issuerLabel.snp.right)
            make.height.equalTo(kCellHeight)
            make.top.equalTo(0)
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
        lab.font = UIFont.systemFont(ofSize: 10)
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

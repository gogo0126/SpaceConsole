//
//  PriceCell.swift
//  SpaceConsole
//
//  Created by Jerry on 2018/7/17.
//  Copyright © 2018 SpaceAdvisor. All rights reserved.
//

import UIKit

class PriceCell: BaseCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.cornerRadius = 7
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let imageView: UIImageView = {
        let imgView = UIImageView(image: UIImage(named: "rectangle"))
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        imgView.cornerRadius = 7
        return imgView
    }()

    let littleIcon1imageView: UIImageView = {
        let imgView = UIImageView(image: UIImage(named: "pathView"))
        imgView.contentMode = .scaleToFill
        imgView.clipsToBounds = true
        return imgView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 10.0)
        label.text = "多功能會議廳-會議專案（半日）"
        return label
    }()

    lazy var detailView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [approvalStatusLabel, lookupTimeLabel, lastUpdateTimeLabel])
        view.axis = .vertical
        view.alignment = .leading
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let approvalStatusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 6.0)
        label.text = "審核通過 / 刊登中"
        return label
    }()

    lazy var lookupTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 6.0)
        label.text = "60天內瀏覽次數：2,380"
        return label
    }()

    lazy var lastUpdateTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 6.0)
        label.text = "最後更新日 2018/06/14"
        return label
    }()

    override func setupViews() {
        addSubview(imageView)
        imageView.addSubview(littleIcon1imageView)
        addSubview(titleLabel)
        addSubview(detailView)

        imageView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(self)
            make.height.equalTo(92)
        }
        
        littleIcon1imageView.snp.makeConstraints { (make) in
            make.left.equalTo(imageView).offset(8)
            make.top.equalTo(imageView).offset(0)
            make.width.equalTo(19)
            make.height.equalTo(34)
        }

        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(6)
            make.right.equalTo(self).offset(-3)
            make.top.equalTo(imageView.snp.bottom).offset(2)
            make.height.equalTo(14)
        }
        
        detailView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(6)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.right.equalTo(self).offset(6)
            make.bottom.equalTo(self.snp.bottom).offset(-4)
        }
    }
    
    func configCell(model: PriceModel) {
        self.backgroundColor = UIColor.white
        titleLabel.text = model.pricePlanName
        approvalStatusLabel.text = model.approvalStatus
        lookupTimeLabel.text = model.lookupTime
        lastUpdateTimeLabel.text = model.lastUpdateTime
    }

}

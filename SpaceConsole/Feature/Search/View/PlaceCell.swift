//
//  PlaceCell.swift
//  SpaceConsole
//
//  Created by Jerry on 2018/7/12.
//  Copyright © 2018 SpaceAdvisor. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
    }
}

class PlaceCell: BaseCell {
    
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
        let imgView = UIImageView(image: UIImage(named: "720view"))
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        imgView.cornerRadius = 7
        return imgView
    }()

    let littleIcon2imageView: UIImageView = {
        let imgView = UIImageView(image: UIImage(named: "preview"))
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        imgView.cornerRadius = 7
        return imgView
    }()

    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 10.0)
        label.text = "宴會大廳堂宴會大廳堂"
        return label
    }()

    let timePlanLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 6.0)
        label.text = "時段制 / 刊登"
        return label
    }()

    lazy var detailView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [lookupTimeLabel, adStatusLabel, placeNoLabel, lastUpdateTimeLabel])
        view.axis = .vertical
        view.alignment = .leading
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var lookupTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 6.0)
        label.text = "60天內瀏覽次數：2,380"
        return label
    }()
    
    lazy var adStatusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 6.0)
        label.text = "廣告狀態：精選標籤/首Banner/優先排序"
        return label
    }()
    
    lazy var placeNoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 6.0)
        label.text = "場地編號 BLTWN01837"
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
        imageView.addSubview(littleIcon2imageView)
        addSubview(titleLabel)
        addSubview(timePlanLabel)
        addSubview(detailView)
        
        imageView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(self)
            make.height.equalTo(92)
        }
        
        littleIcon1imageView.snp.makeConstraints { (make) in
            make.left.equalTo(imageView).offset(7)
            make.top.equalTo(imageView).offset(7)
            make.width.equalTo(15)
            make.height.equalTo(8)
        }
        
        littleIcon2imageView.snp.makeConstraints { (make) in
            make.left.equalTo(littleIcon1imageView.snp.right).offset(4)
            make.top.equalTo(imageView).offset(7)
            make.width.equalTo(15)
            make.height.equalTo(8)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(6)
            make.top.equalTo(imageView.snp.bottom).offset(2)
            make.height.equalTo(14)
        }
        
        timePlanLabel.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-6)
            make.centerY.equalTo(titleLabel)
            make.height.equalTo(8)
        }

        detailView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(6)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.right.equalTo(self).offset(6)
            make.bottom.equalTo(self.snp.bottom).offset(-4)
        }
    }
    
    func configCell(model: PlaceModel) {
        self.backgroundColor = UIColor.white
        titleLabel.text = model.placeName
        timePlanLabel.text = model.timePlane
        lookupTimeLabel.text = model.lookupTime
        adStatusLabel.text = model.adStatus
        placeNoLabel.text = model.placeNo
        lastUpdateTimeLabel.text = model.lastUpdateTime
    }
}

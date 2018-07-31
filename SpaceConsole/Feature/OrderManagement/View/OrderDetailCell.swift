//
//  OrderDetailCell.swift
//  SpaceConsole
//
//  Created by Jerry on 2018/7/26.
//  Copyright © 2018 SpaceAdvisor. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    func setupView() {}
}

class OrderMajorTitleCell: BaseTableViewCell {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    let cellHeight: CGFloat = 50.0

    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
        label.text = ""
        return label
    }()
    
    override func setupView() {
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
    
    func configCell(model: OrderMajorTitleModel) {
        titleLabel.text = model.titleName
    }
    
    override func prepareForReuse() {
        
    }
}

class OrderContactInfoCell: BaseTableViewCell {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    let cellHeight: CGFloat = 114.0
    
    lazy var contactNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 8.0)
        label.text = ""
        return label
    }()
    
    lazy var contactTelLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 8.0)
        label.text = ""
        return label
    }()

    lazy var companyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 8.0)
        label.text = ""
        return label
    }()
    
    lazy var activityTypeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 8.0)
        label.text = ""
        return label
    }()

    lazy var industryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 8.0)
        label.text = ""
        return label
    }()

    lazy var subjectLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 8.0)
        label.text = ""
        return label
    }()

    lazy var activityNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 8.0)
        label.text = ""
        return label
    }()

    lazy var detailView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [contactNameLabel, contactTelLabel, companyLabel, activityTypeLabel, industryLabel, subjectLabel, activityNameLabel])
        view.axis = .vertical
        view.alignment = .leading
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func setupView() {
        addSubview(detailView)
        
        detailView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
    
    func configCell(model: OrderContactInfoModel) {
        contactNameLabel.text = model.contactName
        contactTelLabel.text = model.contactTel
        companyLabel.text = model.company
        activityTypeLabel.text = model.activityType
        industryLabel.text = model.industry
        subjectLabel.text = model.subject
        activityNameLabel.text = model.activityName
    }
    
    override func prepareForReuse() {
        
    }
}

class OrderExpandableCell: BaseTableViewCell {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    let cellHeight: CGFloat = 25.0
    
    lazy var titleNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 10.0)
        label.text = ""
        return label
    }()
    
    private lazy var rightIconImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.image = UIImage(named: "keyboardArrowDownMaterial")
        return imgView
    }()

    override func setupView() {
        addSubview(titleNameLabel)
        addSubview(rightIconImageView)
        
        titleNameLabel.snp.makeConstraints { (make) in
            make.left.top.bottom.equalTo(self)
        }
        
        rightIconImageView.snp.makeConstraints { (make) in
            make.right.equalTo(self)
            make.top.equalTo(self)
            make.bottom.equalTo(self)
            make.width.equalTo(20)
        }
    }

    func configCell(model: OrderExpandableModel) {
        let imgName = model.isExpanded ? "keyboardArrowDownMaterial" : "keyboardArrowTopMaterial"
        rightIconImageView.image = UIImage(named: imgName)
        titleNameLabel.text = model.titleName
    }
}


class OrderDeviceCell: BaseTableViewCell {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    let cellHeight: CGFloat = 14.0
    
    lazy var titleNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 10.0)
        label.text = ""
        return label
    }()
    
    private lazy var iconImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.image = UIImage(named: "star")
        return imgView
    }()
    
    lazy var deviceNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 10.0)
        label.text = ""
        return label
    }()

    lazy var deviceNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 10.0)
        label.text = ""
        return label
    }()

    lazy var remarkLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 10.0)
        label.text = ""
        return label
    }()

    
    override func setupView() {
        addSubview(titleNameLabel)
        addSubview(iconImageView)
        addSubview(deviceNameLabel)
        addSubview(deviceNumberLabel)
        addSubview(remarkLabel)
        
        titleNameLabel.snp.makeConstraints { (make) in
            make.left.top.bottom.equalTo(self)
            make.width.equalTo(40)
        }
        
        iconImageView.snp.makeConstraints { (make) in            make.left.equalTo(titleNameLabel.snp.right).offset(18)
            make.top.equalTo(self)
            make.bottom.equalTo(self)
            make.width.equalTo(20)
        }
        
        deviceNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconImageView.snp.right).offset(5)
            make.top.equalTo(self)
            make.bottom.equalTo(self)
            make.width.equalTo(60)
        }
        
        deviceNumberLabel.snp.makeConstraints { (make) in
            make.left.equalTo(deviceNameLabel.snp.right).offset(18)
            make.top.equalTo(self)
            make.bottom.equalTo(self)
            make.width.equalTo(21)
        }
        
        remarkLabel.snp.makeConstraints { (make) in
            make.left.equalTo(deviceNameLabel.snp.right).offset(18)
            make.top.equalTo(self)
            make.bottom.equalTo(self)
            make.right.equalTo(self)
        }
    }
    
    func configCell(model: OrderDeviceModel) {
        titleNameLabel.text = model.titleName
        deviceNameLabel.text = model.deviceName
        deviceNumberLabel.text = model.deviceNumber
        remarkLabel.text = model.remark
    }
}

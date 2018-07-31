//
//  OrderDetailModel.swift
//  SpaceConsole
//
//  Created by Jerry on 2018/7/27.
//  Copyright © 2018 SpaceAdvisor. All rights reserved.
//

import Foundation

enum OrderDetailCellType: Int {
    case info = 0, contactInfo, majorTitle, expandable, device, foodAdd, remarkItem, segment
}

protocol ExpandableModel {
    var index: Int {get set}
    var isExpandable: Bool {get set}
    var isExpanded: Bool {get set}
    var isVisible: Bool {get set}
    var cellType: OrderDetailCellType {get set}
    var additionalRows: Int {get set}
}

class BaseOrderDetailModel: ExpandableModel {
    var index: Int = 0
    var isExpandable: Bool
    var isExpanded: Bool
    var isVisible: Bool
    var cellType: OrderDetailCellType
    var additionalRows: Int = 0
    
    init(isExpandable: Bool = false, isExpanded: Bool = false, isVisible: Bool = true, cellType: OrderDetailCellType, additionalRows: Int = 0) {
        self.isExpandable = isExpandable
        self.isExpanded = isExpanded
        self.isVisible = isVisible
        self.cellType = cellType
        self.additionalRows = additionalRows
    }
}

class OrderMajorTitleModel: BaseOrderDetailModel {
    var titleName: String
    
    init(titleName: String) {
        self.titleName = titleName
        super.init(cellType: .majorTitle)
    }
}

class OrderContactInfoModel: BaseOrderDetailModel {
    var contactName: String
    var contactTel: String
    var company: String
    var activityType: String
    var industry: String
    var subject: String
    var activityName: String
    
    init(contactName: String, contactTel: String, company: String, activityType: String, industry: String, subject: String, activityName: String) {
        self.contactName = "現場聯繫人姓名：\(contactName)"
        self.contactTel = "現場聯繫人電話：\(contactTel)"
        self.company = "舉辦公司：\(company)"
        self.activityType = "活動性質：\(activityType)"
        self.industry = "產業別：\(industry)"
        self.subject = "科別：\(subject)"
        self.activityName = "活動名稱：\(activityName)"
        super.init(cellType: .contactInfo)
    }
}

class OrderExpandableModel: BaseOrderDetailModel {
    var titleName: String
    
    init(titleName: String) {
        self.titleName = titleName
        super.init(cellType: .expandable)
        self.isExpandable = true
    }
}

class OrderDeviceModel: BaseOrderDetailModel {
    var titleName: String
    var deviceName: String
    var deviceNumber: String
    var remark: String
    
    init(titleName: String, deviceName: String, deviceNumber: String, remark: String) {
        self.titleName = titleName
        self.deviceName = deviceName
        self.deviceNumber = deviceNumber
        self.remark = remark
        super.init(cellType: .device)
    }
}




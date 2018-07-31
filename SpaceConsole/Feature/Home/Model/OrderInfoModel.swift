//
//  OrderInfoModel.swift
//  SpaceConsole
//
//  Created by Jerry on 2018/7/6.
//  Copyright © 2018 SpaceAdvisor. All rights reserved.
//

import Foundation

class OrderInfoModel: BaseOrderDetailModel {
    let orderNo: String
    let applyName: String
    let applyPlace: String
    let applyDate: String
    let orderPlan: String
    let orderPrice: String
    let orderPreviewUrl: String

    init(orderNo: String, applyName: String, applyPlace: String, applyDate: String, orderPlan: String, orderPrice: String, orderPreviewUrl: String) {
        self.orderNo = orderNo
        self.applyName = applyName
        self.applyPlace = applyPlace
        self.applyDate = applyDate
        self.orderPlan = orderPlan
        self.orderPrice = orderPrice
        self.orderPreviewUrl = orderPreviewUrl
        super.init(cellType: .info)
    }
    
}

//struct OrderInfoModel {
//    let orderNo: String
//    let applyName: String
//    let applyPlace: String
//    let applyDate: String
//    let orderPlan: String
//    let orderPrice: String
//    let orderPreviewUrl: String
//}

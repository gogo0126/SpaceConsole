//
//  SideMenuModel.swift
//  SpaceConsole
//
//  Created by Jerry on 2018/7/3.
//  Copyright © 2018 SpaceAdvisor. All rights reserved.
//

import Foundation

enum SideMenuName: String {
    case editProfile = "編輯個人資料"
    case home = "控制面板"
    case ownerPage = "場地主頁面預覽"
    case placeList = "管理您的場地清單"
    case priceList = "您的價格方案清單"
    case orderManagement = "訂單管理"
    case successOrder = "已成交訂單"
    case waitApprovalOrder = "待審核訂單"
    case waitPayOrder = "待付款訂單"
    case canceledOrder = "已取消訂單"
    case historyOrder = "歷史訂單"
    case questionAnswer = "常見問題"
    case logout = "登出"
}

class SideMenuModel {
    var menuName: SideMenuName
    var isExpandable: Bool
    var expanded: Bool
    var isSubMenu: Bool
    var subMenu: [SideMenuModel]?
    var isVisible: Bool
    var parent: SideMenuName?
    
    required init(menuName: SideMenuName, isExpandable: Bool, expanded: Bool, isSubMenu: Bool, subMenu: [SideMenuModel]?, isVisible: Bool = true, parent: SideMenuName? = nil) {
        self.menuName = menuName
        self.isExpandable = isExpandable
        self.expanded = expanded
        self.isSubMenu = isSubMenu
        self.parent = parent
        self.subMenu = subMenu
        self.isVisible = isVisible
    }
    
}

//struct SubMenuModel {
//    let title: String
//}

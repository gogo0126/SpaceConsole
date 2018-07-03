//
//  SideMenuModel.swift
//  SpaceConsole
//
//  Created by Jerry on 2018/7/3.
//  Copyright © 2018 SpaceAdvisor. All rights reserved.
//

import Foundation

class SideMenuModel {
    var title: String
    var isExpandable: Bool
    var expanded: Bool
    var isSubMenu: Bool
    var subMenu: [SideMenuModel]?
    var isVisible: Bool
    var parent: String?
    
    required init(title: String, isExpandable: Bool, expanded: Bool, isSubMenu: Bool, subMenu: [SideMenuModel]?, isVisible: Bool = true, parent: String? = nil) {
        self.title = title
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

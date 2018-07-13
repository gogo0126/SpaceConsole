//
//  SideMenuCell.swift
//  SpaceConsole
//
//  Created by Jerry on 2018/7/3.
//  Copyright © 2018 SpaceAdvisor. All rights reserved.
//

import UIKit

class SideMenuCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var expandLabel: UILabel!
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var leftImageViewLeadingContraint: NSLayoutConstraint!
    
    let imageNameList = ["homeMaterial",
                         "attachMoneyMaterial",
                         "formatListBulletedMaterial",
                         "personMaterial",
                         "pictureOutlinedFontAwesome",
                         "questionCircleFontAwesome",
                         "tagAnticon"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        self.leftImageView?.image = UIImage()
    }
    
    func configCellLayout(model: SideMenuModel) {
        self.titleLabel.text = model.title
        self.expandLabel.isHidden = !model.isExpandable
//        self.expandLabel.text = model.expanded ? "△" : "▽"
        self.expandLabel.text = ""
        if model.isSubMenu {
            self.leftImageViewLeadingContraint.constant = 59
        } else {
            self.leftImageView.image = UIImage(named: getImageName(title: model.title))
            self.leftImageViewLeadingContraint.constant = 19
        }
    }
    
    func getImageName(title: String) -> String {
        switch title {
        case "控制面版":
            return "homeMaterial"
        case "場地主頁面預覽":
            return "pictureOutlinedFontAwesome"
        case "管理您的場地清單":
            return "formatListBulletedMaterial"
        case "您的價格方案清單":
            return "tagAnticon"
        case "訂單管理":
            return "attachMoneyMaterial"
        case "常見問題":
            return "questionCircleFontAwesome"
        case "登出":
            return "personMaterial"
        default:
            return "homeMaterial"
        }
    }
    
}

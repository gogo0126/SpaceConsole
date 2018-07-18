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
        self.titleLabel.text = model.menuName.rawValue
        self.expandLabel.isHidden = !model.isExpandable
//        self.expandLabel.text = model.expanded ? "△" : "▽"
        self.expandLabel.text = ""
        if model.isSubMenu {
            self.leftImageViewLeadingContraint.constant = 59
        } else {
            self.leftImageView.image = UIImage(named: getImageName(menuName: model.menuName))
            self.leftImageViewLeadingContraint.constant = 19
        }
    }
    
    func getImageName(menuName: SideMenuName) -> String {
        switch menuName {
            case .home:
                return "homeMaterial"
            case .ownerPage:
                return "pictureOutlinedFontAwesome"
            case .placeList:
                return "formatListBulletedMaterial"
            case .priceList:
                return "tagAnticon"
            case .orderManagement:
                return "attachMoneyMaterial"
            case .questionAnswer:
                return "questionCircleFontAwesome"
            case .logout:
                return "personMaterial"
            default:
                return "homeMaterial"
        }
    }
    
}

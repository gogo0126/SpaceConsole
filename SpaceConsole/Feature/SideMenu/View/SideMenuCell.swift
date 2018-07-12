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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCellLayout(model: SideMenuModel) {
        self.backgroundColor = UIColor.gray
        self.titleLabel.text = model.title
        self.expandLabel.isHidden = !model.isExpandable
        self.expandLabel.text = model.expanded ? "△" : "▽"
        if model.isSubMenu {
            self.contentView.layoutMargins.left = 40
        } else {
            self.contentView.layoutMargins.left = 0

        }
    }
    
}

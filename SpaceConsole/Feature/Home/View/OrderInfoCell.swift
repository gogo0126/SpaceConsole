//
//  OrderInfoCell.swift
//  SpaceConsole
//
//  Created by Jerry on 2018/7/9.
//  Copyright © 2018 SpaceAdvisor. All rights reserved.
//

import UIKit
import MGSwipeTableCell

class OrderInfoCell: MGSwipeTableCell {

    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var applyNameLabel: UILabel!
    @IBOutlet weak var applyPlaceLabel: UILabel!
    @IBOutlet weak var applyDateLabel: UILabel!
    @IBOutlet weak var orderPlanLabel: UILabel!
    @IBOutlet weak var orderPriceLabel: UILabel!
    @IBOutlet weak var orderNoLabel: UILabel!
    @IBOutlet weak var middleView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

        
//    override var frame: CGRect {
//        get {
//            return super.frame
//        }
//        set {
//            var newFrame = newValue
////            newFrame.origin.x += 10
//            newFrame.size.width -= 40
//            super.frame = newFrame
//        }
//    }

    func configCell(model: OrderInfoModel) {        
        self.backgroundColor = UIColor.spaLightGray
        self.contentView.backgroundColor = UIColor.spaLightGray
        
        self.leftImageView.sd_setImage(with: URL(string: model.orderPreviewUrl), completed: nil)
        self.applyNameLabel.text = "申請人：\(model.applyName)"
        self.applyPlaceLabel.text = "申請場地：\(model.applyPlace)"
        self.applyDateLabel.text = "申請日期：\(model.applyDate)"
        self.orderPlanLabel.text = "方案桌數：\(model.orderPlan)"
        self.orderPriceLabel.text = "價位：\(model.orderPrice)"
        self.orderNoLabel.text = "訂單編號：\(model.orderNo)"
    }
    
}


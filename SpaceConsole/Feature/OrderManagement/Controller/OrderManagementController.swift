//
//  OrderManagementController.swift
//  SpaceConsole
//
//  Created by Jerry on 2018/7/23.
//  Copyright © 2018 SpaceAdvisor. All rights reserved.
//

import UIKit
import HMSegmentedControl
import MGSwipeTableCell

enum OrderStatus: Int {
    case success = 0
    case waitApproval = 1
    case waitPay = 2
    case canceled = 3
    case history = 4
}


class OrderManagementController: BaseViewController {
    
    var successList: [OrderInfoModel]?
    var waitApprovalList: [OrderInfoModel]?
    var waitPayList: [OrderInfoModel]?
    var canceledList: [OrderInfoModel]?
    var historyList: [OrderInfoModel]?
    var orderStatus: OrderStatus! = .success

    lazy var orderSegmentControl: HMSegmentedControl = {
        let segmentControl = HMSegmentedControl()
        segmentControl.sectionTitles = ["已成交", "待確認", "待付款", "已取消", "歷史"]
        segmentControl.selectionStyle = .fullWidthStripe
        segmentControl.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.spaGreyish, NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14)]
        segmentControl.selectedTitleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.spaBrickRed, NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14)]
        segmentControl.selectionIndicatorLocation = .down
        segmentControl.selectionIndicatorColor = UIColor.spaBrickRed
        segmentControl.selectionIndicatorHeight = 3.0
        segmentControl.segmentWidthStyle = .fixed
        segmentControl.backgroundColor = UIColor.spaLightGray
        segmentControl.indexChangeBlock = { [weak self] page in
            self!.orderScrollView.scrollRectToVisible(
                CGRect(x: self!.orderScrollView.frame.width * CGFloat(page), y: 0, width: self!.orderScrollView.frame.width, height: self!.orderScrollView.frame.height), animated: true)
            self!.orderStatus = OrderStatus(rawValue: Int(page))
        }
        
        return segmentControl
    }()
    
    lazy var orderScrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.isPagingEnabled = true
        sv.delegate = self
        return sv
    }()
    
    let contentView: UIView = {
        let cv = UIView()
        return cv
    }()
    
    lazy var successTableView: UITableView = {
        return createTableView()
    }()
    
    lazy var waitApprovalTableView: UITableView = {
        return createTableView()
    }()

    lazy var waitPayTableView: UITableView = {
        return createTableView()
    }()

    lazy var canceledTableView: UITableView = {
        return createTableView()
    }()

    lazy var historyTableView: UITableView = {
        return createTableView()
    }()


    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "訂單管理"
        self.view.backgroundColor = UIColor.spaLightGray
        
        setupView()
        
        createFakeData()
    }
    
    override func viewDidLayoutSubviews() {
        orderSegmentControl.addDefaultUnderline()
    }

    func setupView() {
        view.addSubview(orderSegmentControl)
        view.addSubview(orderScrollView)
        orderScrollView.addSubview(contentView)
        contentView.addSubview(successTableView)
        contentView.addSubview(waitApprovalTableView)
        contentView.addSubview(waitPayTableView)
        contentView.addSubview(canceledTableView)
        contentView.addSubview(historyTableView)
        
        orderSegmentControl.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(self.view)
            make.height.equalTo(36)
        }
        
        orderScrollView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view)
            make.top.equalTo(orderSegmentControl.snp.bottom)
            make.right.equalTo(self.view)
            make.bottom.equalTo(self.view)
        }
        
        contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(orderScrollView)
            make.height.equalTo(orderScrollView)
        }
        
        successTableView.snp.makeConstraints { (make) in
            make.left.top.bottom.equalTo(self.contentView)
            make.width.equalTo(orderScrollView.snp.width)
            make.height.equalTo(orderScrollView.snp.height)
        }
        
        waitApprovalTableView.snp.makeConstraints { (make) in
            make.left.equalTo(successTableView.snp.right)
            make.top.bottom.equalTo(self.contentView)
            make.width.equalTo(orderScrollView.snp.width)
            make.height.equalTo(orderScrollView.snp.height)
        }

        waitPayTableView.snp.makeConstraints { (make) in
            make.left.equalTo(waitApprovalTableView.snp.right)
            make.top.bottom.equalTo(self.contentView)
            make.width.equalTo(orderScrollView.snp.width)
            make.height.equalTo(orderScrollView.snp.height)
        }

        canceledTableView.snp.makeConstraints { (make) in
            make.left.equalTo(waitPayTableView.snp.right)
            make.top.bottom.equalTo(self.contentView)
            make.width.equalTo(orderScrollView.snp.width)
            make.height.equalTo(orderScrollView.snp.height)
        }

        historyTableView.snp.makeConstraints { (make) in
            make.right.equalTo(contentView.snp.right)
            make.left.equalTo(canceledTableView.snp.right)
            make.top.bottom.equalTo(self.contentView)
            make.width.equalTo(orderScrollView.snp.width)
            make.height.equalTo(orderScrollView.snp.height)
        }

    }
    
    private func createTableView() -> UITableView {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor.clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderHeight = 11.7
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 10))
        tableView.tableFooterView = footerView
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        return tableView
    }

}

// MARK: - UIScrollViewDelegate
extension OrderManagementController: UIScrollViewDelegate {

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == orderScrollView {
            let page = UInt(scrollView.contentOffset.x / scrollView.frame.size.width)
            self.orderSegmentControl.setSelectedSegmentIndex(page, animated: true)
            self.orderStatus = OrderStatus(rawValue: Int(page))
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension OrderManagementController: UITableViewDelegate, UITableViewDataSource {
    func createFakeData() {
        successList = []
        for index in 0...20 {
            let item = OrderInfoModel(orderNo: "T201807060000\(index)", applyName: "申請人\(index)", applyPlace: "申請場地\( index)", applyDate: "申請日期\(index)", orderPlan: "方案桌數\(index)", orderPrice: "價位\(index)", orderPreviewUrl: "https://www.spaceadvisor.com/image/timthumb.php?src=https://www.spaceadvisor.com/image/upload/space_000040/product_img/JmRub7d0LJ1WwdsOkiBfLD6xfHvd7HJg.jpg&h=580&w=1670&zc=1")
            successList?.append(item)
        }
        self.successTableView.reloadData()
        
        waitApprovalList = []
        for index in 0...10 {
            let item = OrderInfoModel(orderNo: "T201807060000\(index)", applyName: "申請人\(index)", applyPlace: "申請場地\( index)", applyDate: "申請日期\(index)", orderPlan: "方案桌數\(index)", orderPrice: "價位\(index)", orderPreviewUrl: "https://www.spaceadvisor.com/image/timthumb.php?src=https://www.spaceadvisor.com/image/upload/space_000040/product_img/JmRub7d0LJ1WwdsOkiBfLD6xfHvd7HJg.jpg&h=580&w=1670&zc=1")
            waitApprovalList?.append(item)
        }
        self.waitApprovalTableView.reloadData()
        
        waitPayList = []
        for index in 0...15 {
            let item = OrderInfoModel(orderNo: "T201807060000\(index)", applyName: "申請人\(index)", applyPlace: "申請場地\( index)", applyDate: "申請日期\(index)", orderPlan: "方案桌數\(index)", orderPrice: "價位\(index)", orderPreviewUrl: "https://www.spaceadvisor.com/image/timthumb.php?src=https://www.spaceadvisor.com/image/upload/space_000040/product_img/JmRub7d0LJ1WwdsOkiBfLD6xfHvd7HJg.jpg&h=580&w=1670&zc=1")
            waitPayList?.append(item)
        }
        self.waitApprovalTableView.reloadData()

        canceledList = []
        for index in 0...3 {
            let item = OrderInfoModel(orderNo: "T201807060000\(index)", applyName: "申請人\(index)", applyPlace: "申請場地\( index)", applyDate: "申請日期\(index)", orderPlan: "方案桌數\(index)", orderPrice: "價位\(index)", orderPreviewUrl: "https://www.spaceadvisor.com/image/timthumb.php?src=https://www.spaceadvisor.com/image/upload/space_000040/product_img/JmRub7d0LJ1WwdsOkiBfLD6xfHvd7HJg.jpg&h=580&w=1670&zc=1")
            canceledList?.append(item)
        }
        self.canceledTableView.reloadData()

        historyList = []
        for index in 0...50 {
            let item = OrderInfoModel(orderNo: "T201807060000\(index)", applyName: "申請人\(index)", applyPlace: "申請場地\( index)", applyDate: "申請日期\(index)", orderPlan: "方案桌數\(index)", orderPrice: "價位\(index)", orderPreviewUrl: "https://www.spaceadvisor.com/image/timthumb.php?src=https://www.spaceadvisor.com/image/upload/space_000040/product_img/JmRub7d0LJ1WwdsOkiBfLD6xfHvd7HJg.jpg&h=580&w=1670&zc=1")
            historyList?.append(item)
        }
        self.historyTableView.reloadData()
    }
    
    func getList() -> [OrderInfoModel] {
        switch orderStatus {
        case .success:
            if let list = successList {
                return list
            }
        case .waitApproval:
            if let list = waitApprovalList {
                return list
            }
        case .waitPay:
            if let list = waitPayList {
                return list
            }
        case .canceled:
            if let list = canceledList {
                return list
            }
        case .history:
            if let list = historyList {
                return list
            }
        default:
            return [OrderInfoModel]()
        }
        return [OrderInfoModel]()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 11.7
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.clear
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return getList().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! OrderInfoCell
        let model = getList()[indexPath.row]
        cell.configCell(model: model)
        
        let assignButton = MGSwipeButton(title: "指派負責人", backgroundColor: .white) {
            (sender: MGSwipeTableCell!) -> Bool in
            ViewManager.sharedManager.showAlert(message: "指派負責人")
            return false
        }
        assignButton.cornerRadius = 7.0
        assignButton.setTitleColor(.black, for: .normal)
        assignButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        
        
        let messageButton = MGSwipeButton(title: "訊息", backgroundColor: .white) {
            (sender: MGSwipeTableCell!) -> Bool in
            ViewManager.sharedManager.showAlert(message: "訊息")
            return true
        }
        messageButton.cornerRadius = 7.0
        messageButton.setTitleColor(.black, for: .normal)
        messageButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)

        cell.rightButtons = [assignButton, messageButton]
        cell.rightSwipeSettings.buttonsDistance = 2
        cell.rightSwipeSettings.enableSwipeBounces = true
        cell.rightSwipeSettings.swipeBounceRate = 0.0
    
        return cell
    }
    
    
}

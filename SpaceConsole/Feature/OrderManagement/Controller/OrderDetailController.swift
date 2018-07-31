//
//  OrderInfomationController.swift
//  SpaceConsole
//
//  Created by Jerry on 2018/7/26.
//  Copyright © 2018 SpaceAdvisor. All rights reserved.
//

import UIKit


class OrderDetailController: BaseViewController {
    
    let orderInfoCellIdentifier = "OrderInfoCell"
    let orderMajorTitleCellIdentifier = "OrderMajorTitleCell"
    let orderContactInfoCellIdentifier = "OrderContactInfoCell"
    let orderExpandableCellIdentifier = "OrderExpandableCell"
    let orderDeviceCellIdentifier = "OrderDeviceCell"
    
    lazy var tableView: UITableView = {
        return createTableView()
    }()
    
    lazy var orderDetailRows: [BaseOrderDetailModel] = {
        let list = [
            OrderInfoModel(orderNo: "T201807060000\(index)", applyName: "申請人\(index)", applyPlace: "申請場地\( index)", applyDate: "申請日期\(index)", orderPlan: "方案桌數\(index)", orderPrice: "價位\(index)", orderPreviewUrl: "https://www.spaceadvisor.com/image/timthumb.php?src=https://www.spaceadvisor.com/image/upload/space_000040/product_img/JmRub7d0LJ1WwdsOkiBfLD6xfHvd7HJg.jpg&h=580&w=1670&zc=1"),
            OrderMajorTitleModel(titleName: "聯絡人資訊"),
            OrderContactInfoModel(contactName: "何某某", contactTel: "0917987654", company: "台鹽生技", activityType: "會議與培訓", industry: "醫療產業", subject: "內科", activityName: "內科"),
            OrderMajorTitleModel(titleName: "加購項目"),
            OrderExpandableModel(titleName: "設備加購"),
            OrderDeviceModel(titleName: "舞台設備", deviceName: "固定式投影機", deviceNumber: "10個", remark: "我是備註"),
            OrderDeviceModel(titleName: "", deviceName: "固定式投影機", deviceNumber: "10個", remark: "我是備註"),
            
//            OrderDetailModel(isExpandable: false, isExpanded: false, isVisible: true, cellType: .basic),
//            OrderDetailModel(isExpandable: false, isExpanded: false, isVisible: true, cellType: .majorTitle),
//            OrderDetailModel(isExpandable: false, isExpanded: false, isVisible: true, cellType: .contactInfo),
//            OrderDetailModel(isExpandable: false, isExpanded: false, isVisible: true, cellType: .majorTitle),
//            OrderDetailModel(isExpandable: true, isExpanded: false, isVisible: true, cellType: .expandable, additionalRows: 1),
//            OrderDetailModel(isExpandable: false, isExpanded: false, isVisible: false, cellType: .majorTitle),
//            OrderDetailModel(isExpandable: true, isExpanded: false, isVisible: true, cellType: .expandable, additionalRows: 1),
//            OrderDetailModel(isExpandable: false, isExpanded: false, isVisible: false, cellType: .basic),
            ]
        
        for i in 0..<list.count {
            list[i].index = i
        }
        return list
    }()
    
    
    var visibleRows: [BaseOrderDetailModel] {
        get {
            return orderDetailRows.filter { return $0.isVisible }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "訂單資訊"

        self.view.backgroundColor = UIColor.spaLightGray
        
        setupView()

    }

    func setupView() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
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
        tableView.register(UINib(nibName: orderInfoCellIdentifier, bundle: nil), forCellReuseIdentifier: orderInfoCellIdentifier)
        tableView.register(OrderMajorTitleCell.self, forCellReuseIdentifier: orderMajorTitleCellIdentifier)
        tableView.register(OrderContactInfoCell.self, forCellReuseIdentifier: orderContactInfoCellIdentifier)
        tableView.register(OrderExpandableCell.self, forCellReuseIdentifier: orderExpandableCellIdentifier)
        tableView.register(OrderDeviceCell.self, forCellReuseIdentifier: orderDeviceCellIdentifier)
        
        return tableView
    }


}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension OrderDetailController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return visibleRows.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = visibleRows[indexPath.row].cellType
        switch cellType {
        case .info:
            let cell = tableView.dequeueReusableCell(withIdentifier: orderInfoCellIdentifier, for: indexPath) as! OrderInfoCell
            let model = visibleRows[indexPath.row] as! OrderInfoModel
            cell.configCell(model: model)
            return cell
        case .contactInfo:
            let cell = tableView.dequeueReusableCell(withIdentifier: orderContactInfoCellIdentifier, for: indexPath) as! OrderContactInfoCell
            let model = visibleRows[indexPath.row] as! OrderContactInfoModel
            cell.configCell(model: model)
            return cell
        case .expandable:
            let cell = tableView.dequeueReusableCell(withIdentifier: orderExpandableCellIdentifier, for: indexPath) as! OrderExpandableCell
            let model = visibleRows[indexPath.row] as! OrderExpandableModel
            cell.configCell(model: model)
            return cell
        case .majorTitle:
            let cell = tableView.dequeueReusableCell(withIdentifier: orderMajorTitleCellIdentifier, for: indexPath) as! OrderMajorTitleCell
            let model = visibleRows[indexPath.row] as! OrderMajorTitleModel
            cell.configCell(model: model)
            return cell
        case .device:
            let cell = tableView.dequeueReusableCell(withIdentifier: orderDeviceCellIdentifier, for: indexPath) as! OrderDeviceCell
            let model = visibleRows[indexPath.row] as! OrderDeviceModel
            cell.configCell(model: model)
            return cell
        default:
            fatalError()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = visibleRows[indexPath.row]
        if model.isExpandable {
            model.isExpanded = !model.isExpanded
            
            orderDetailRows.forEach { (item: BaseOrderDetailModel) in
                if item.index == model.index {
                    for i in (item.index+1)...(item.index + item.additionalRows) {
                        orderDetailRows[i].isVisible = model.isExpanded
                    }
                    
                    
                    tableView.reloadData()
                    tableView.beginUpdates()
                    tableView.endUpdates()
                    return
                }
            }
                
        }
    }
    

}

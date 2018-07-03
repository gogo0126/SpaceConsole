//
//  SideMenuViewController.swift
//  SpaceConsole
//
//  Created by Jerry on 2018/7/2.
//  Copyright © 2018 SpaceAdvisor. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SideMenuViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var ownerLabel: UILabel!
    
    @IBOutlet weak var editPersonalInfoButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var accountNameLabel: UILabel!
    
    let cellIdentifier: String! = "SideMenuCell"
    
    let disposeBag = DisposeBag()
    
    var defaultItems:[SideMenuModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.backgroundColor = UIColor.gray

        self.tableView.register(UINib(nibName: "SideMenuCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        defaultItems = [
            SideMenuModel(title: "控制面板", isExpandable: false, expanded: false, isSubMenu: false, subMenu: nil),
            SideMenuModel(title: "場地主頁面預覽", isExpandable: false, expanded: false, isSubMenu: false, subMenu: nil),
            SideMenuModel(title: "管理您的場地清單", isExpandable: false, expanded: false, isSubMenu: false, subMenu: nil),
            SideMenuModel(title: "您的價格方案清單", isExpandable: false, expanded: false, isSubMenu: false, subMenu: nil),
            SideMenuModel(title: "訂單管理", isExpandable: true, expanded: false, isSubMenu: false,
                          subMenu:nil),
            SideMenuModel(title: "已成交訂單", isExpandable: false, expanded: false, isSubMenu: true, subMenu: nil, isVisible: false, parent:"訂單管理" ),
                SideMenuModel(title: "待審核訂單", isExpandable: false, expanded: false, isSubMenu: true, subMenu: nil, isVisible: false, parent:"訂單管理"),
                SideMenuModel(title: "待付款訂單", isExpandable: false, expanded: false, isSubMenu: true, subMenu: nil, isVisible: false, parent:"訂單管理"),
                SideMenuModel(title: "已取消訂單", isExpandable: false, expanded: false, isSubMenu: true, subMenu: nil, isVisible: false, parent:"訂單管理"),
                SideMenuModel(title: "歷史訂單", isExpandable: false, expanded: false, isSubMenu: true, subMenu: nil, isVisible: false, parent:"訂單管理"),
            
            SideMenuModel(title: "常見問題", isExpandable: false, expanded: false, isSubMenu: false, subMenu: nil),
            SideMenuModel(title: "登出", isExpandable: false, expanded: false, isSubMenu: false, subMenu: nil)
            ]
        
        
        self.reBind()
    
        Observable.zip(tableView.rx.itemSelected, tableView.rx.modelSelected(SideMenuModel.self))
            .bind { [weak self] indexPath, item in
                self?.tableView.deselectRow(at: indexPath, animated: false)
                
                let model = self!.defaultItems![indexPath.row]
                model.expanded = !model.expanded
                let title = model.title
                
                self?.defaultItems!.forEach() {
                    if $0.parent == title {
                        $0.isVisible = !$0.isVisible
                    }
                }
                
                self?.tableView.delegate = nil
                self?.tableView.dataSource = nil

                self?.reBind()
                self?.tableView.beginUpdates()
                self?.tableView.reloadData()
                self?.tableView.endUpdates()
                
            }
            .disposed(by: disposeBag)
        
    }
    
    func getSource() -> Observable<[SideMenuModel]> {
        return Observable.just(defaultItems)
            .map {
                $0!.filter { $0.isVisible }
            }
    }
    
    func reBind() {
        let items = getSource()
        items.bind(to: tableView.rx.items) { (tableView, row, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier) as! SideMenuCell
            
            cell.configCellLayout(model: element)
            //                cell.textLabel?.text = "\(row)：\(element)"
            return cell
            }
            .disposed(by: disposeBag)
    }

    @IBAction func editPersonalInfoButtonPressed(_ sender: UIButton) {
        
    }
    
}

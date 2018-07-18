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
    @IBOutlet weak var memberView: UIView!
    
    let cellIdentifier: String! = "SideMenuCell"
    
    let disposeBag = DisposeBag()
    
    var defaultItems:[SideMenuModel]? = {
        let items = [
            SideMenuModel(menuName: .home, isExpandable: false, expanded: false, isSubMenu: false, subMenu: nil),
            SideMenuModel(menuName: .ownerPage, isExpandable: false, expanded: false, isSubMenu: false, subMenu: nil),
            SideMenuModel(menuName: .placeList, isExpandable: false, expanded: false, isSubMenu: false, subMenu: nil),
            SideMenuModel(menuName: .priceList, isExpandable: false, expanded: false, isSubMenu: false, subMenu: nil),
            SideMenuModel(menuName: .orderManagement, isExpandable: true, expanded: false, isSubMenu: false,
            subMenu:nil),
            SideMenuModel(menuName: .successOrder, isExpandable: false, expanded: false, isSubMenu: true, subMenu: nil, isVisible: false, parent: .orderManagement ),
            SideMenuModel(menuName: .waitApprovalOrder, isExpandable: false, expanded: false, isSubMenu: true, subMenu: nil, isVisible: false, parent: .orderManagement),
            SideMenuModel(menuName: .waitPayOrder, isExpandable: false, expanded: false, isSubMenu: true, subMenu: nil, isVisible: false, parent: .orderManagement),
            SideMenuModel(menuName: .canceledOrder, isExpandable: false, expanded: false, isSubMenu: true, subMenu: nil, isVisible: false, parent: .orderManagement),
            SideMenuModel(menuName: .historyOrder, isExpandable: false, expanded: false, isSubMenu: true, subMenu: nil, isVisible: false, parent: .orderManagement),
            
            SideMenuModel(menuName: .questionAnswer, isExpandable: false, expanded: false, isSubMenu: false, subMenu: nil),
            SideMenuModel(menuName: .logout, isExpandable: false, expanded: false, isSubMenu: false, subMenu: nil)
        ]
        return items
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        self.memberView.backgroundColor = UIColor.spaBrickRed
        self.tableView.backgroundColor = UIColor.clear
        self.imageView.cornerRadius = self.imageView.frame.width / 2
        

        self.tableView.register(UINib(nibName: "SideMenuCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        self.reBind()
    
        Observable.zip(tableView.rx.itemSelected, tableView.rx.modelSelected(SideMenuModel.self))
            .bind { [weak self] indexPath, item in
                self?.tableView.deselectRow(at: indexPath, animated: false)
                
                let model = self!.defaultItems![indexPath.row]
                
                if !model.isExpandable {
                    ViewManager.sharedManager.closeLeftSideMenu()
                    ViewManager.sharedManager.toPriceList()
                    ViewManager.sharedManager.toPage(menuName: model.menuName)
                    return
                }
                
                model.expanded = !model.expanded
                let menuName = model.menuName
                
                self?.defaultItems!.forEach() {
                    if $0.parent == menuName {
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

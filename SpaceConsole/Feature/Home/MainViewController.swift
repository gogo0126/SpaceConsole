//
//  MainViewController.swift
//  SpaceConsole
//
//  Created by Jerry on 2018/7/2.
//  Copyright © 2018 SpaceAdvisor. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import SDWebImage
import HMSegmentedControl
import MGSwipeTableCell

class MainViewController: UIViewController {

    @IBOutlet weak var bannerContentView: UIView!
    @IBOutlet weak var bannerView: UIScrollView!
    @IBOutlet weak var orderSegmentControl: HMSegmentedControl!
    @IBOutlet weak var orderScrollView: UIScrollView!
    @IBOutlet weak var leftTableView: UITableView!
    @IBOutlet weak var rightTableView: UITableView!
    @IBOutlet weak var orderScrollViewHeight: NSLayoutConstraint!

    let disposeBag = DisposeBag()
    var pageControl: UIPageControl?
    var bannerTimer: Timer?
    var bannerContentList: [String]?
    var orderWaitApprovalList: [OrderInfoModel]?
    var orderNewList: [OrderInfoModel]?
    let cellIdentifier: String! = "OrderInfoCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Space Advisor"

        self.leftTableView.register(UINib(nibName: "OrderInfoCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        self.rightTableView.register(UINib(nibName: "OrderInfoCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)

        setupLeftBarItem()
        setupBannerView()
        setBannerList()
        setupSegment()
        createFakeData()
    }

    override func viewDidLayoutSubviews() {
        if self.orderSegmentControl.selectedSegmentIndex == 0 {
            self.leftTableView.layoutIfNeeded()
            self.orderScrollViewHeight.constant = self.leftTableView.contentSize.height
        }
        else {
            self.rightTableView.layoutIfNeeded()
            self.orderScrollViewHeight.constant = self.rightTableView.contentSize.height
        }
        
    }
    
    func setupLeftBarItem() {
        let leftItem = UIBarButtonItem(title: "=", style: .plain, target: self
            , action:nil)
        
        leftItem.rx.tap
            .subscribe(onNext: {
                ViewManager.sharedManager.openLeftSideMenu()
            })
            .disposed(by: disposeBag)
        
        self.navigationItem.leftBarButtonItem = leftItem
    }
    
    @objc func openLeftMenu() {
        ViewManager.sharedManager.openLeftSideMenu()
    }
    
    func setupSegment() {
        orderSegmentControl.sectionTitles = ["待審核訂單", "最新成交訂單"]
        orderSegmentControl.selectionStyle = .fullWidthStripe
        orderSegmentControl.selectionIndicatorLocation = .down
        orderSegmentControl.segmentWidthStyle = .fixed
        orderSegmentControl.backgroundColor = UIColor.gray
        orderSegmentControl.indexChangeBlock = { index in
            self.orderScrollView.scrollRectToVisible(
                CGRect(x: self.orderScrollView.frame.width * CGFloat(index), y: 0, width: self.orderScrollView.frame.width, height: self.orderScrollView.frame.height), animated: true)
        }
        
        self.orderScrollView.delegate = self
    }
    
}

// banner
extension MainViewController: UIScrollViewDelegate {
    func setupBannerView() {
        self.bannerView.delegate = self
        self.bannerView.isPagingEnabled = true
        
        self.pageControl = UIPageControl()
        self.view.addSubview(self.pageControl!)
        self.pageControl!.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.bannerView).offset(-10)
            make.centerX.equalTo(self.bannerView)
            make.height.equalTo(15)
        }
    }
    
    func setBannerList() {
        self.invalidTimer()
        
        bannerContentList = ["https://www.spaceadvisor.com/image/timthumb.php?src=https://www.spaceadvisor.com/image/upload/space_000243/product_img/HwGLHVqVRLloIOvgJFKjqpC16I4g5FQY.jpg&h=580&w=1670&zc=1",
                             "https://www.spaceadvisor.com/image/timthumb.php?src=https://www.spaceadvisor.com/image/upload/space_000035/product_img/82DADF5A-F453-55B2-E097-1586ED3DBBA0.jpg&h=580&w=1670&zc=1",
                             "https://www.spaceadvisor.com/image/timthumb.php?src=https://www.spaceadvisor.com/image/upload/space_000026/product_img/NTa17b4kqsj7Av4ROKVhbHdo5CLLRcCD.jpg&h=580&w=1670&zc=1"]
//        let color = [UIColor.blue, .brown, .purple, .blue]
        
        var preView: UIImageView?
        for index in 0...bannerContentList!.count {
            let url = URL(string: self.bannerContentList![index % bannerContentList!.count])
            let view = UIImageView()
            view.sd_setImage(with: url!, completed: nil)
            
//            view.backgroundColor = color[index % bannerContentList!.count]
            self.bannerContentView.addSubview(view)
            view.snp.makeConstraints { (make) in
                make.top.equalTo(self.bannerView)
                make.bottom.equalTo(self.bannerView)
                make.width.equalTo(self.bannerView)
                make.height.equalTo(self.bannerView)
                if index == 0 {
                    make.leading.equalTo(self.bannerContentView)
                }
                else {
                    make.leading.equalTo(preView!.snp.trailing)
                }
                
                if index == bannerContentList!.count {
                    make.trailing.equalTo(self.bannerContentView.snp.trailing)
                }
            }
            preView = view
        }
        
        self.pageControl?.numberOfPages = bannerContentList!.count
        
        setupTimer()
    }
    
    func setupTimer() {
        if self.bannerTimer != nil { return }

        self.bannerTimer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(timerAction(timer:)), userInfo: nil, repeats: true)
    }
    
    @objc func timerAction(timer: Timer) {
        let newOffset =  CGPoint(x: CGFloat((self.pageControl?.currentPage)! + 1) * (self.bannerView.frame.width),y: 0)
        
        self.bannerView.setContentOffset(newOffset, animated: true)

    }
    
    func invalidTimer() {
        self.bannerTimer?.invalidate()
        self.bannerTimer = nil
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.bannerView {
            let index = roundf(Float(self.bannerView!.contentOffset.x / self.bannerView.frame.width))
            if (bannerContentList!.count != 0) {
                self.pageControl?.currentPage = Int(index) % self.bannerContentList!.count
            }
            
            let bannerContentWidth = self.bannerView.frame.width * CGFloat(self.bannerContentList!.count)
            if self.bannerView.contentOffset.x < 0 {
                let newOffset = CGPoint(x: self.bannerView.contentOffset.x + bannerContentWidth, y: 0)
                self.bannerView.setContentOffset(newOffset, animated: false)
            }
            else if self.bannerView.contentOffset.x >= bannerContentWidth {
                let newOffset = CGPoint(x: self.bannerView.contentOffset.x - bannerContentWidth, y: 0)
                self.bannerView.setContentOffset(newOffset, animated: false)
            }
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if scrollView == self.bannerView {
            self.invalidTimer()
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == self.bannerView {
            self.setupTimer()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == self.orderScrollView {
            let page = UInt(scrollView.contentOffset.x / scrollView.frame.size.width)
            self.orderSegmentControl.setSelectedSegmentIndex(page, animated: true)
        }

    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func createFakeData() {
        orderWaitApprovalList = []
        for index in 0...20 {
            let item = OrderInfoModel(orderNo: "T201807060000\(index)", applyName: "申請人\(index)", applyPlace: "申請場地\( index)", applyDate: "申請日期\(index)", orderPlan: "方案桌數\(index)", orderPrice: "價位\(index)", orderPreviewUrl: "https://www.spaceadvisor.com/image/timthumb.php?src=https://www.spaceadvisor.com/image/upload/space_000040/product_img/JmRub7d0LJ1WwdsOkiBfLD6xfHvd7HJg.jpg&h=580&w=1670&zc=1")
            orderWaitApprovalList?.append(item)
        }
        self.leftTableView.reloadData()
        
        orderNewList = []
        for index in 0...10 {
            let item = OrderInfoModel(orderNo: "T201807060000\(index)", applyName: "申請人\(index)", applyPlace: "申請場地\( index)", applyDate: "申請日期\(index)", orderPlan: "方案桌數\(index)", orderPrice: "價位\(index)", orderPreviewUrl: "https://www.spaceadvisor.com/image/timthumb.php?src=https://www.spaceadvisor.com/image/upload/space_000040/product_img/JmRub7d0LJ1WwdsOkiBfLD6xfHvd7HJg.jpg&h=580&w=1670&zc=1")
            orderNewList?.append(item)
        }
        self.rightTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == leftTableView {
            if let _ = self.orderWaitApprovalList {
                return 1
            }
        }
        else {
            if let _ = self.orderNewList {
                return 1
            }
        }

        return 0
        
//        if tableView == leftTableView {
//            if let list = self.orderWaitApprovalList {
//                return list.count
//            }
//        }
//        else {
//            if let list = self.orderNewList {
//                return list.count
//            }
//        }
//
//        return 0

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == leftTableView {
            if let list = self.orderWaitApprovalList {
                return list.count
            }
        }
        else {
            if let list = self.orderNewList {
                return list.count
            }
        }

        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.clear
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == leftTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier) as! OrderInfoCell
            let model = self.orderWaitApprovalList![indexPath.row]
            cell.configCell(model: model)
            
            //configure right buttons
            let rejectButton = MGSwipeButton(title: "拒絕",backgroundColor: .lightGray) {
                (sender: MGSwipeTableCell!) -> Bool in
                ViewManager.sharedManager.showAlert(message: "已拒絕")
                return false
            }
            rejectButton.cornerRadius = 7.0
            
            let acceptButton = MGSwipeButton(title: "接受", backgroundColor: .red) {
                (sender: MGSwipeTableCell!) -> Bool in
                ViewManager.sharedManager.showAlert(message: "已接受")
                return true
            }
            acceptButton.cornerRadius = 7.0
            cell.rightButtons = [rejectButton, acceptButton]
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier) as! OrderInfoCell
            let model = self.orderNewList![indexPath.row]
            cell.configCell(model: model)
            
            //configure right buttons
            let rejectButton = MGSwipeButton(title: "拒絕",backgroundColor: .lightGray) {
                (sender: MGSwipeTableCell!) -> Bool in
                ViewManager.sharedManager.showAlert(message: "已拒絕")
                return false
            }
            rejectButton.cornerRadius = 7.0
            
            let acceptButton = MGSwipeButton(title: "接受", backgroundColor: .red) {
                (sender: MGSwipeTableCell!) -> Bool in
                ViewManager.sharedManager.showAlert(message: "已接受")
                return true
            }
            acceptButton.cornerRadius = 7.0
            cell.rightButtons = [rejectButton, acceptButton]
            return cell
        }
    }
    

}

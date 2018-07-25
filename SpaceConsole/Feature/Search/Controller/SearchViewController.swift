//
//  PlaceViewController.swift
//  SpaceConsole
//
//  Created by Jerry on 2018/7/12.
//  Copyright © 2018 SpaceAdvisor. All rights reserved.
//

import UIKit
import SnapKit

enum SearchType {
    case place
    case price
}

class SearchViewController: BaseViewController {
    
    private let padding: CGFloat = 10
    private let reuseIdentifier = "PlaceCell"
    var placeList: [PlaceModel]?
    var priceList: [PriceModel]?
    var searchType: SearchType
    
    
    init(searchType: SearchType) {
        self.searchType = searchType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var collectionView: UICollectionView? = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(self.padding, self.padding, self.padding, self.padding)

        let cv = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height), collectionViewLayout: layout)
        let classType = searchType == .place ? PlaceCell.self : PriceCell.self
        cv.register(classType, forCellWithReuseIdentifier: reuseIdentifier)
        cv.contentInset = UIEdgeInsetsMake(90, 0, 70, 0)
        cv.scrollIndicatorInsets = UIEdgeInsetsMake(90, 0, 0, 0)
        cv.backgroundColor = UIColor.spaLightGray
        
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    
    lazy var placeFilterPanel: PlaceFilterPanel = {
        let panel = PlaceFilterPanel()
        panel.pickerViewDidShowedHandler = { [weak self] () in
            print("do something")
        }
        panel.backgroundColor = UIColor.spaLightGray
        return panel
    }()
    
    lazy var priceFilterMenu: PriceFilterPanel = {
        let panel = PriceFilterPanel()
        panel.backgroundColor = UIColor.spaLightGray
        return panel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = searchType == .place ? "管理你的場地清單" : "您的價格方案清單"
        
        setupCollectionView()
        
        searchType == .place ? setupPlaceFilterPanel() : setupPriceFilterPanel()
        
        loadData()
    }
    
    private func setupPlaceFilterPanel() {
        view.addSubview(placeFilterPanel)
        placeFilterPanel.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(view)
            make.height.equalTo(90)
        }
    }
    
    private func setupPriceFilterPanel() {
        view.addSubview(priceFilterMenu)
        priceFilterMenu.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(view)
            make.height.equalTo(90)
        }
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView!)
    }
    
    func loadData() {
        if searchType == .place {
            placeList = []
            for _ in 0...20 {
                let model = PlaceModel(placeName: "宴會大廳堂宴會大廳堂", timePlane: "時段制 / 刊登", lookupTime: "60天內瀏覽次數：2,380", adStatus: "廣告狀態：精選標籤/首Banner/優先排序", placeNo: "場地編號 BLTWN01837", lastUpdateTime: "最後更新日 2018/06/14")
                placeList?.append(model)
            }
        }
        else {
            priceList = []
            for _ in 0...20 {
                let model = PriceModel(pricePlanName: "多功能會議廳-會議專案（半日)", approvalStatus: "審核通過 / 刊登中", lookupTime: "60天內瀏覽次數：0", lastUpdateTime: "最後更新日 2018/06/14")
                priceList?.append(model)
            }

        }
        
        collectionView?.reloadData()
    }

}


extension SearchViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
        
    // MARK: UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let list = placeList {
            return list.count
        }
        else if let list = priceList {
            return list.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width - padding * 3) / 2, height: 152)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? PlaceCell {
            let model = placeList![indexPath.item] as PlaceModel
            cell.configCell(model: model)
            return cell
        }
        else if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? PriceCell {
            let model = priceList![indexPath.item] as PriceModel
            cell.configCell(model: model)
            return cell
        }
        else {
            fatalError("return incorrect cell")
        }
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */
    
}

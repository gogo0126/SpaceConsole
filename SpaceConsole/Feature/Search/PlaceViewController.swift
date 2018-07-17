//
//  PlaceViewController.swift
//  SpaceConsole
//
//  Created by Jerry on 2018/7/12.
//  Copyright © 2018 SpaceAdvisor. All rights reserved.
//

import UIKit
import SnapKit

class PlaceViewController: BaseViewController {
    
    private let padding: CGFloat = 10
    private let reuseIdentifier = "PlaceCell"
    var placeList: [PlaceModel]?
    
    lazy var collectionView: UICollectionView? = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(self.padding, self.padding, self.padding, self.padding)

        let cv = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height), collectionViewLayout: layout)
        
        cv.register(PlaceCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        cv.contentInset = UIEdgeInsetsMake(90, 0, 70, 0)
        cv.scrollIndicatorInsets = UIEdgeInsetsMake(90, 0, 0, 0)
        cv.backgroundColor = UIColor.spaLightGray
        
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    
    lazy var searchMenu: SearchPanel = {
        let search = SearchPanel()
        search.pickerViewDidShowedHandler = { [weak self] () in
            print("do something")
        }
        search.backgroundColor = UIColor.spaLightGray
        return search
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "管理你的場地清單"
        self.navigationController?.navigationBar.isTranslucent = false
        
        setupCollectionView()
        setupSearchMenu()
        
        loadData()
    }
    
    private func setupSearchMenu() {
        view.addSubview(searchMenu)
        searchMenu.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(view)
            make.height.equalTo(90)
        }
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView!)
    }
    
    func loadData() {
        placeList = []
        for _ in 0...20 {
            let model = PlaceModel(placeName: "宴會大廳堂宴會大廳堂", timePlane: "時段制 / 刊登", lookupTime: "60天內瀏覽次數：2,380", adStatus: "廣告狀態：精選標籤/首Banner/優先排序", placeNo: "場地編號 BLTWN01837", lastUpdateTime: "最後更新日 2018/06/14")
            placeList?.append(model)
        }
        
        collectionView?.reloadData()
    }

}


extension PlaceViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
        
    // MARK: UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let list = placeList {
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PlaceCell
        cell.configCell(model: placeList![indexPath.item])
    
        return cell
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

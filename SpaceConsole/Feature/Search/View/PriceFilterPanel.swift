//
//  PriceFilterPanel.swift
//  SpaceConsole
//
//  Created by Jerry on 2018/7/17.
//  Copyright © 2018 SpaceAdvisor. All rights reserved.
//

import UIKit
import RxSwift

class PriceFilterPanel: UIControl {

    let disposeBag = DisposeBag()
    var priceSearchModel = PriceSearchModel(keyword: "", pricePlanStartDate: "", pricePlanEndDate: "")
    var isPressDone: Bool = false
    
    let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "yyyy/MM/dd"
        return df
    }()

    let blackView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        return view
    }()

    lazy var keywordTextfield: UITextField = {
        let textfield = UITextField()
        textfield.borderStyle = .roundedRect
        textfield.returnKeyType = .search
        textfield.placeholder = "場地關鍵字"
        textfield.leftViewMode = .always
        textfield.font = UIFont.systemFont(ofSize: 10)
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 20))
        imgView.contentMode = .right
        imgView.image = UIImage(named: "searchMaterial")
        textfield.leftView = imgView
        textfield.delegate = self
        return textfield
    }()

    lazy var pricePlanStartDateTextfield: UITextField = {
        let textfield = UITextField()
        textfield.borderStyle = .roundedRect
        textfield.returnKeyType = .search
        textfield.placeholder = "選擇方案適用開始日期"
        textfield.font = UIFont.systemFont(ofSize: 10)
        textfield.inputView = pricePlanStartDatePickerView
        textfield.delegate = self
        textfield.inputAccessoryView = doneToolBar
        return textfield
    }()
    
    lazy var pricePlanEndDateTextfield: UITextField = {
        let textfield = UITextField()
        textfield.borderStyle = .roundedRect
        textfield.returnKeyType = .search
        textfield.placeholder = "選擇方案適用結束日期"
        textfield.font = UIFont.systemFont(ofSize: 10)
        textfield.inputView = pricePlanEndDatePickerView
        textfield.delegate = self
        textfield.inputAccessoryView = doneToolBar
        return textfield
    }()
    
    lazy var doneToolBar: UIToolbar = {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 44))
        toolbar.barStyle = .default
        let cancelButton = UIBarButtonItem (barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonPressed(item:)))
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPressed(item:)))
        let flexSpaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        toolbar.items = [cancelButton, flexSpaceButton, doneButton]
        
        return toolbar
    }()

    
    lazy var pricePlanStartDatePickerView: UIDatePicker = {
        let pickView = UIDatePicker()
        pickView.datePickerMode = .date
        pickView.locale = Locale.init(identifier: "zh_TW")
        pickView.date = Date.init()
        return pickView
    }()

    lazy var pricePlanEndDatePickerView: UIDatePicker = {
        let pickView = UIDatePicker()
        pickView.datePickerMode = .date
        pickView.locale = Locale.init(identifier: "zh_TW")
        pickView.date = Date.init()
        return pickView
    }()


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        addSubview(keywordTextfield)
        addSubview(pricePlanStartDateTextfield)
        addSubview(pricePlanEndDateTextfield)

        keywordTextfield.snp.makeConstraints { (make) in
            make.left.top.equalTo(self).offset(12)
            make.right.equalTo(self).offset(-12)
        }

        pricePlanStartDateTextfield.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(12)
            make.top.equalTo(keywordTextfield.snp.bottom).offset(12)
            make.width.equalTo(pricePlanEndDateTextfield)
        }

        pricePlanEndDateTextfield.snp.makeConstraints { (make) in            make.left.equalTo(pricePlanStartDateTextfield.snp.right).offset(12)
            make.right.equalTo(self).offset(-12)
            make.top.equalTo(keywordTextfield.snp.bottom).offset(12)
            make.width.equalTo(pricePlanStartDateTextfield)
        }

    }
}

extension PriceFilterPanel {
    @objc func cancelButtonPressed(item: UIBarButtonItem) {
        isPressDone = false
        self.endEditing(true)
        
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
            self.blackView.removeFromSuperview()
        }
    }
    
    @objc func doneButtonPressed(item: UIBarButtonItem) {
        isPressDone = true
        self.endEditing(true)
        
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
            self.blackView.removeFromSuperview()
        }
    }
}

extension PriceFilterPanel: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == keywordTextfield {
            return true
        }
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        isPressDone = false
        
        if let window = UIApplication.shared.keyWindow {
            window.addSubview(blackView)
            blackView.frame = window.frame
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cancelButtonPressed(item:))))
            
            blackView.alpha = 0
            
            UIView.animate(withDuration: 0.5) {
                self.blackView.alpha = 1
            }
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == keywordTextfield {
            priceSearchModel.keyword = textField.text!
            return
        }
        
        
        if (textField == pricePlanStartDateTextfield) {
            if isPressDone {
                let dateString = dateFormatter.string(from: pricePlanStartDatePickerView.date)
                priceSearchModel.pricePlanStartDate = dateString
                textField.text = dateString
            }
            else {
                if let lastDate = dateFormatter.date(from: priceSearchModel.pricePlanStartDate) {
                    pricePlanStartDatePickerView.date = lastDate
                }
            }
        }
        else if (textField == pricePlanEndDateTextfield) {
            if isPressDone {
                let dateString = dateFormatter.string(from: pricePlanEndDatePickerView.date)
                priceSearchModel.pricePlanEndDate = dateString
                textField.text = dateString
            }
            else {
                if let lastDate = dateFormatter.date(from: priceSearchModel.pricePlanEndDate) {
                    pricePlanEndDatePickerView.date = lastDate
                }
            }
        }

    }
}

struct PriceSearchModel {
    var keyword: String
    var pricePlanStartDate: String
    var pricePlanEndDate: String
}

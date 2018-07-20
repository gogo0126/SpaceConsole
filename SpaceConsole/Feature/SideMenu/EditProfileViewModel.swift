//
//  EditProfileViewModel.swift
//  SpaceConsole
//
//  Created by Jerry on 2018/7/18.
//  Copyright © 2018 SpaceAdvisor. All rights reserved.
//

import Foundation

class EditProfileViewModel {
    
    var profileModel: ProfileModel = ProfileModel(email: "quinni.shen@spaceadvisor.com", password: "123456", confirmPassword: "123456", chLastName: "XX", chFirstName: "陳", engLastName: "Chen", engFirstName: "Joe", department: "Product team", professionalTitle: "PM", contactTel: "0229382923", contactTelExtension: "05", contactPhone: "0918123456") {
        didSet {
            reloadProfileData?()
        }
    }
    

    private var isLoading: Bool = false {
        didSet {
            updateLoadingStatus!(isLoading)
        }
    }
    
    
    var updateLoadingStatus: ((Bool) -> Void)?
    var reloadProfileData: (() -> Void)?
    var showMessage: ((String) -> Void)?
    
    func loadData() {
        isLoading = true
        
        
        isLoading = false
    }
    
    func savePressed() {
        showMessage?("haha")
    }
}

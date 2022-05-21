//
//  BaseVM.swift
//  SahanRavindu
//
//  Created by Sahan Ravindu on 2022-05-21.
//

import Foundation

class BaseVM {
    func createLoacalUser(loginUser: User?) {
        LocalUser.saveLoginData(user: loginUser)
    }
    
}

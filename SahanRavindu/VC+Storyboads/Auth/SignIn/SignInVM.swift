//
//  SignInVM.swift
//  SahanRavindu
//
//  Created by Sahan Ravindu on 2022-05-21.
//

import Foundation
import RealmSwift

class SignInVM: BaseVM {
    //MARK: Variable
    var localUser: User?
    
    override init() {
        
    }
    
    init(user: User) {
        localUser = user
    }
    
    func signIn(completion: @escaping ActionHandler) {
        if LocalUser.current()?.fullName != localUser?.fullName {
            completion(false, "User cannot be found or invalid user")
        } else {
            UserDefaultsManager.setLogedInUser(true)
            completion(true, "")
        }
    }
    
}

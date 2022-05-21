//
//  SignUpVM.swift
//  SahanRavindu
//
//  Created by Sahan Ravindu on 2022-05-21.
//

import Foundation
import RealmSwift

class SignUpVM: BaseVM {
    //MARK: Variable
    var localUser: User?
    
    override init() {
        
    }
    
    init(user: User) {
        localUser = user
    }
    
    func signUp(completion: @escaping ActionHandler) {
        guard let _user = localUser else {
            completion(false, "Unable to create user")
            return
        }
        
        createLoacalUser(loginUser: _user)
        UserDefaultsManager.setLogedInUser(true)
        completion(true, "")
    }
    
}

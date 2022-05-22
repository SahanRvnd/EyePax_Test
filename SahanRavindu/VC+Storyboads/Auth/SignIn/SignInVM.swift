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
        } else if  LocalUser.current()?.fullName == localUser?.fullName && LocalUser.current()?.accessToken == localUser?.accessToken {
            UserDefaultsManager.setLogedInUser(true)
            completion(true, "")
        } else {
            completion(false, "Invalid credentials")
        }
    }
    
}

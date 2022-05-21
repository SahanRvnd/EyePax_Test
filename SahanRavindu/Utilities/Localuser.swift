//
//  Localuser.swift
//  SahanRavindu
//
//  Created by Sahan Ravindu on 2021-01-31.
//

import Foundation
import RealmSwift

class LocalUser: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var uuid: String = ""
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var fullName: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var avatarUrl: String = ""
    @objc dynamic var address: String = ""
    @objc dynamic var phone: String = ""
    @objc dynamic var status: Int = 0
    @objc dynamic var longitude: String = ""
    @objc dynamic var latitude: String = ""
    @objc dynamic var aboutMe: String = ""
    @objc dynamic var accessToken: String = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    // Get the first object of User Model
    class func current() -> LocalUser? {
        let users = try! Realm().objects(LocalUser.self)
        return users.first
    }
    
    
    class func saveLoginData(user: User?) {
        guard (LocalUser.current() == nil) else {
            RealmService.shared.remove(objectsOfInstanceType: LocalUser.self) // Remove if exists
            self.createLocalUser(user: user) // Write user then
            return
        }
        
        self.createLocalUser(user: user) // Write user
    }
    
    
    class func createLocalUser(user: User?) {
        
        let newUser = LocalUser()
        newUser.id = user?._id ?? 0
        newUser.firstName = user?.firstName ?? ""
        newUser.lastName = user?.lastName ?? ""
        newUser.fullName = user?.fullName ?? ""
        newUser.email = user?.email ?? ""
        newUser.avatarUrl = user?.avatarUrl ?? ""
        newUser.phone = user?.phone ?? ""
        newUser.accessToken = user?.accessToken ?? ""
        
        RealmService.shared.create(object: newUser)
        
    }
    
    class func UpdateProfileData(type: ProfileUpdateType, user: User?) {
        
        if let currentUser = LocalUser.current() {
            switch type {
            case .Info:
                let dict: [String: Any?] = ["firstName": user?.firstName ?? "", "email": user?.email ?? "", "lastName": user?.lastName ?? "", "fullName": user?.fullName ?? "", "phone": user?.phone ?? ""]
                RealmService.shared.update(object: currentUser, with: dict)
                break
            case .Avatar:
                let dict: [String: Any?] = ["avatarUrl": user?.avatarUrl ?? ""]
                RealmService.shared.update(object: currentUser, with: dict)
            default:
                break
            }
        }
    }
}

enum ProfileUpdateType {
    case Info, Avatar, Unknown
}

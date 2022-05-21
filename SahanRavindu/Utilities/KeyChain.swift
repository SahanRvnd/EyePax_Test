//
//  KeyChain.swift
//  SahanRavindu
//
//  Created by Sahan Ravindu on 2022-05-21.
//

import Foundation
import Security
import UIKit

struct KeychainConfiguration {
    static let serviceName = "EyePaxTest"
    static let accessGroup: String? = nil
}

class KeyChainManager {
//    func setPasswordToKeychain(login: String, pass: String){
//      do{
//        let passwordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName,
//                                                account: login,
//                                                accessGroup: KeychainConfiguration.accessGroup)
//
//
//        // Save in keychain
//        try passwordItem.savePassword(pass)
//      } catch { print(error.localizedDescription) }
//    }
}

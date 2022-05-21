//
//  ApplicationControl.swift
//  SahanRavindu
//
//  Created by Sahan Ravindu on 2021-01-31.
//

import Foundation
import UIKit

struct ApplicationControl {
    
    // Check with app scope and update values below
    static let appMainInterfaceType: MainInterfaceType = .Main
    
    static let appLoginMethod: LoginMothod = .None
    static let appResetPassswordType: ResetPassswordType = .Email
    static let appChangePassswordType: ChangePassswordType = .CurrentPassword_NewPassword
    
    static let credentialsLoginType: CredentialsLoginType = .Email_Password
    static let socialLoginTypes: [SocialLoginType] = []
}


// App Login methods
public enum LoginMothod {
    case None
    case CredentialsLogin
    case SocialLogin
    case DeviceLogin
}


// Credentials Login types
public enum CredentialsLoginType {
    case Email_Password
    case Username_Password
    case Mobile_Password
    case Email_Or_Username_Password
    case Email_OTP
    case Mobile_OTP
    case Username_OTP
    case Email_Or_Mobile_OTP
}


// Social Login types
public enum SocialLoginType {
    case Facebook
    case Twitter
    case Google
    case Apple
}


// Reset Password types
public enum ResetPassswordType {
    case Email
    case Username
    case Mobile
}


// Change Password types
public enum ChangePassswordType {
    case CurrentPassword_NewPassword
    case Token_NewPassword
}


// Main Interface type
public enum MainInterfaceType {
    case Main
    case SideMenuNavigations
    case TabBarNavigations
    case Custom
}


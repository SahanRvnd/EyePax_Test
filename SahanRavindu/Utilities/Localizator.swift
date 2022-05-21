//
//  Localizator.swift
//  SahanRavindu
//
//  Created by Sahan Ravindu on 2021-01-29.
//

import Foundation
import UIKit


public class Localizator {
    fileprivate func NSLocalizedString(_ key: String) -> String {
        return Foundation.NSLocalizedString(key, comment: "")
    }
}

extension String {
    // Unwind Segue Identifiers
    
    // Navigation bar titles
    
    // Loader messages
    static let Login = NSLocalizedString("Login...", comment: "")
    static let Registering = NSLocalizedString("Registering...", comment: "")
    static let Logout = NSLocalizedString("Logout...", comment: "")
    static let Loading = NSLocalizedString("Loading...", comment: "")
    
    // File extensions
    static let PDF = NSLocalizedString("pdf", comment: "")
    static let HTML = NSLocalizedString("html", comment: "")
    static let DOCX = NSLocalizedString("docx", comment: "")
    static let PNG = NSLocalizedString("png", comment: "")
    
    // Nibs
    
    // Alert titles
    static let Alert = NSLocalizedString("Alert", comment: "")
    static let Confirmation = NSLocalizedString("Confirmation", comment: "")
    static let Error = NSLocalizedString("Error", comment: "")
    static let Incomplete = NSLocalizedString("Incomplete", comment: "")
    static let Success = NSLocalizedString("Success", comment: "")
    static let Failed = NSLocalizedString("Failed", comment: "")
    static let Oops = NSLocalizedString("Oops", comment: "")
    static let Warning = NSLocalizedString("Warning", comment: "")
    static let ResetEmailSent = NSLocalizedString("A password reset link has been sent. Please check your email.", comment: "")
    static let SomethingWentWrong = NSLocalizedString("Something went wrong.", comment: "")
    
    
    
    // ALERT MESSAGES
    // Local error messages
    static let ErrorCorrupted = NSLocalizedString("Error is corrupted.", comment: "")
    static let MissingData = NSLocalizedString("Missing data in the request.", comment: "")
    static let AnyFieldEmpty = NSLocalizedString("All fields are required.", comment: "")
    static let MissingRequiredFields = NSLocalizedString("Missing some required fields.", comment: "")
    static let NameEmpty = NSLocalizedString("Please enter name.", comment: "")
    static let FirstNameEmpty = NSLocalizedString("Please enter firstname.", comment: "")
    static let LastNameEmpty = NSLocalizedString("Please enter lastname.", comment: "")
    static let OccupationNotPicked = NSLocalizedString("Please select occupation.", comment: "")
    static let AnyPasswordEmpty = NSLocalizedString("Please fill both password fields.", comment: "")
    static let EmailEmpty = NSLocalizedString("Please enter email address.", comment: "")
    static let PasswordEmpty = NSLocalizedString("Please enter password.", comment: "")
    static let PhoneEmpty = NSLocalizedString("Please enter phone number.", comment: "")
    static let InvalidEmail = NSLocalizedString("Invalid email address.", comment: "")
    static let InvalidPhone = NSLocalizedString("Invalid phone number.", comment: "")
    static let InvalidUrl = NSLocalizedString("Invalid url.", comment: "")
    static let InvalidPassword = NSLocalizedString("Invalid password.", comment: "")
    //static let ShorterPassword = NSLocalizedString("Password should be at least \(Constant.Counts.passwordCount) characters.", comment: "")
    static let MismatchingPasswords = NSLocalizedString("Passwords do not match.", comment: "")
    static let NoCameraPermission = NSLocalizedString("No camera permission set.", comment: "")
    static let CurrentPasswordEmpty = NSLocalizedString("Please enter current password.", comment: "")
    static let NewPasswordEmpty = NSLocalizedString("Please enter new password.", comment: "")
    static let ConfirmPasswordEmpty = NSLocalizedString("Please enter confirm password.", comment: "")
    static let newCurrentMatchPasswords = NSLocalizedString("Current password and new password can not be same.", comment: "")
    static let RetryMessage = NSLocalizedString("Failed to upload profile picture. Please try again.", comment: "")
    static let SuccessfullyUpdated = NSLocalizedString("Profile updated successfully.", comment: "")
    static let SubjectMissing = NSLocalizedString("Please enter subject", comment: "")
    static let MessageMissing = NSLocalizedString("Please enter message", comment: "")
    static let MissingQuestion = NSLocalizedString("Please enter Question", comment: "")
    static let InternetConnectionOffline = NSLocalizedString("Internet connection appears to be offline. ", comment: "")
    static let openTermsCondition = NSLocalizedString("Read \"Terms & Conditions\" befor signup.", comment: "")
    static let AddressMissing = NSLocalizedString("Pleas Enter Address", comment: "")
    static let PetMissing = NSLocalizedString("Pleas Select/Create a pet", comment: "")
    static let CaptionMissing = NSLocalizedString("Pleas add a caption for the post", comment: "")
     static let VideoMissing = NSLocalizedString("Pleas select a video for the post", comment: "")
    // Success messages
    
    // Failure messages
    static let MisingData = NSLocalizedString("Missing data in the request.", comment: "")
    
    // No data messages
    
    // Info messages
    static let FeatureNotImplemented = NSLocalizedString("This feature is not implemented.", comment: "")
    
    // Confirmation messages
    static let LogoutConfirmation = NSLocalizedString("Are you sure you want to logout?", comment: "")
    static let DeleteMeConfirmation = NSLocalizedString("Are you sure you want to deleye your account?", comment: "")
    
    // Action titles
    static let Ok = NSLocalizedString("OK", comment: "")
    static let Cancel = NSLocalizedString("Cancel", comment: "")
    static let Yes = NSLocalizedString("Yes", comment: "")
    static let No = NSLocalizedString("No", comment: "")
    static let Retry = NSLocalizedString("Retry", comment: "")
    static let Dismiss = NSLocalizedString("Dismiss", comment: "")
    static let Call = NSLocalizedString("Call", comment: "")
    static let Settings = NSLocalizedString("Settings", comment: "")
    static let Continue = NSLocalizedString("Continue", comment: "")
    static let Create = NSLocalizedString("Create", comment: "")
    static let Add = NSLocalizedString("Add", comment: "")
    static let Update = NSLocalizedString("Update", comment: "")
    static let Delete = NSLocalizedString("Delete", comment: "")
    static let Skip = NSLocalizedString("Skip", comment: "")
    static let Subscribe = NSLocalizedString("Subscribe", comment: "")
    
    static let TakePhoto = NSLocalizedString("Take Photo", comment: "")
    static let ChooseFromLibrary = NSLocalizedString("Choose from Library", comment: "")
    static let TakeVideo = NSLocalizedString("Take Video", comment: "")
    // Placeholders
    
    // Other
    static let NotApplicable = NSLocalizedString("N/A", comment: "")
    static let LineBreak = NSLocalizedString("\n", comment: "")
    static let QuestionMark = NSLocalizedString("?", comment: "")
    static let SingleQotation = NSLocalizedString("'", comment: "")
    static let EmptyString = NSLocalizedString("", comment: "")
    
    // Storyboard identifiers
    
    //MARK: ViewControllers
    //Auth
    static let SignInVC = NSLocalizedString("SignInVC", comment: "")
    static let SignUpVC = NSLocalizedString("SignUpVC", comment: "")
    static let TabBarVC = NSLocalizedString("TabBarVC", comment: "")
    static let MainVC = NSLocalizedString("MainVC", comment: "")
    
    //MARK: Navigation Controllers
    // Top viewController of the Storyboard
    static let AuthNC = NSLocalizedString("AuthNC", comment: "")
    static let SignUpNC = NSLocalizedString("SignUpNC", comment: "")
    static let SignInNC = NSLocalizedString("SignInNC", comment: "")
    static let TabBarNC = NSLocalizedString("TabBarNC", comment: "")
    static let MainNC = NSLocalizedString("MainNC", comment: "")
   
    
    // Error messages with API
    
}

extension UIImage {
    
}

extension UIColor {
    
    static let buttonLightColor = UIColor(red:0.33, green:0.77, blue:0.82, alpha:1)
    static let buttonDarkColor = UIColor(red:0.27, green:0.65, blue:0.69, alpha:1)
}

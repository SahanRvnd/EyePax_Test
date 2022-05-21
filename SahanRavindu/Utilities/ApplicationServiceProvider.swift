//
//  ApplicationServiceProvider.swift
//  SahanRavindu
//
//  Created by Sahan Ravindu on 2021-01-29.
//

import Foundation
import UIKit

enum Storyboard: String {
    case Auth
    case Main
}

class ApplicationServiceProvider {
    
    static let shared = ApplicationServiceProvider()
    
    let bundleId = Bundle.main.bundleIdentifier ?? ""
    let deviceId = UIDevice.current.identifierForVendor!.uuidString
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    let sceneDelegate: SceneDelegate = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)!
    let deviceType = "APPLE"
    
    // Initial parameters for authenication services (Login / Register)
    var initialAuthParameters: [String: Any] = [:]
    
    private init() {}
    
    //MARK: Manage User Direction
    public func manageUserDirection(from vc: UIViewController? = nil, window: UIWindow? = nil) {
        guard LocalUser.current() != nil else {
            directToPath(in: .Auth, for: .SignUpNC, from: vc, window: window)
            return
        }
        // Set access token to SwaggerClientAPI.customHeaders and iBaseSwift AppConstant.customHeaders
        setupAccessToken()
        getRedirectionWithMainInterfaceType(type: ApplicationControl.appMainInterfaceType, window: window)
    }
    
    //MARK: Get ridirection with app main interface type
    func getRedirectionWithMainInterfaceType(type: MainInterfaceType, from vc: UIViewController? = nil, window: UIWindow? = nil) {
        switch type {
        case .Main:
            directToPath(in: .Main, for: .MainNC, from: vc, window: window)
        case .SideMenuNavigations:
           break
        case .TabBarNavigations:
            break
        case .Custom:
            break
        }
    }
    
    //MARK: Direct to Main Root window
    public func directToPath(in sb: Storyboard, for identifier: String, from vc: UIViewController? = nil, window: UIWindow? = nil) {
        let storyboard = UIStoryboard(name: sb.rawValue, bundle: nil)
        let topController = storyboard.instantiateViewController(withIdentifier: identifier)
        
        sceneDelegate.setAsRoot(_controller: topController)
    }
    
    
    //MARK: Navigation push view Controller
    public func pushToViewController(in sb: Storyboard, for identifier: String, from vc: UIViewController?, data: Any? = nil) {
        
        let storyboard = UIStoryboard(name: sb.rawValue, bundle: nil)
        let destVc = storyboard.instantiateViewController(withIdentifier: identifier)
        
        vc?.navigationController?.pushViewController(destVc, animated: true)
        
    }
    
    //MARK: Present view Controller
    public func presentViewController(in sb: Storyboard, for identifier: String, from vc: UIViewController?, style: UIModalPresentationStyle = .overCurrentContext, data: Any? = nil) {
        
        let storyboard = UIStoryboard(name: sb.rawValue, bundle: nil)
        let destVc = storyboard.instantiateViewController(withIdentifier: identifier)
        
        destVc.modalPresentationStyle = style
        vc?.present(destVc, animated: true, completion: nil)
    }
    
    
    //MARK: Setup access token
    func setupAccessToken() {
        guard LocalUser.current() != nil else {
            return
        }
        //SwaggerClientAPI.customHeaders.updateValue(iBSUserDefaults.getAccessToken(), forKey: "x-access-token")
    }
}

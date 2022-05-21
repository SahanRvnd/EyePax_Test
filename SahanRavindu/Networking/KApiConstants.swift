//
//  Constants.swift
//  SahanRavindu
//
//  Created by Dushan Saputhanthri on 26/6/18.
//  Copyright © 2018 Elegant Media Pvt Ltd. All rights reserved.
//

import Foundation

// Action Handler
//typealias ActionHandler = (_ status: Bool, _ message: String) -> ()

// Completion Handler
//typealias CompletionHandler = (_ status: Bool, _ message: String, _ data: Any?) -> ()

enum AppEnvironment {
    case sandbox
    case staging
    case production
}

struct K {
    
    struct AppServer {
        static var baseURL: String {
            get {
                return "https://api.themoviedb.org/3/movie"
            }
        }
    }
    
    struct APIParameterKey {
        
        //Sign Up //Log In
        static let image = "image"
        static let username = "username"
        static let password = "password"
        static let name = "name"
        static let social_type = "social_type"
        static let device_id = "device_id"
        static let social_token = "social_token"
        static let social_userid = "social_userid"
        static let email = "email"
        static let deviceType = "deviceType"
        static let fcmToken = "deviceId";
        
        //User Update
        static let mobile_number = "mobile_number"
        static let date_of_birth = "date_of_birth"
        static let gender = "gender"
        static let language = "language"
        static let whitelisted = "whitelisted"
        static let country = "country"
        
        static let key = "api_key"
        static let page = "page"
    }
}

enum HTTPHeaderField: String {
    case authorization = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}

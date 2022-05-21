//
//  Constant.swift
//  Template
//
//  Created by Sahan Ravindu on 2021-08-24.
//

import Foundation

struct KConstant {
    
    //MARK: Manage app environment with release type
    static let appEnvironment: DeploymentEnvironment = .production
    
    static let shared = UserDefaults.standard
    
    //MARK: Custom headers
    public static var customHeaders: [String: String] = [:]
    
    //MARK: Current App Version
    public static let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    
    //MARK: Realm schema version
    public static let schemaVision = 1
    
    
    //MARK: App environments
    enum DeploymentEnvironment {
        case development
        case staging
        case production
    }
    
    //MARK: Get URLs (Base url etc.)
    enum URLs {
        static let baseUrl = getBaseURL()
    }
    
    //MARK: Provide base url for current app environment
    static func getBaseURL() -> String {
        switch KConstant.appEnvironment {
        case .development:
            return "https://newsapi.org/v2/"
        case .production:
            return "https://newsapi.org/v2/"
        case .staging:
            return "https://newsapi.org/v2/"
        }
    }
    
    //MARK: Get access token
    public static func getAccessToken() -> String {
        if let token = shared.string(forKey: "ACCESS_TOKEN") {
            return token
        }
        return ""
    }

    
    //MARK: Get Updated Custom headers
    public static func getCustomHeaders() -> [String: String] {
        
        customHeaders = ["x-api-key": "", "Accept" : "application/json"]
        
        //Check access token exits
        let accessToken = getAccessToken()
        
        if !(accessToken.isEmpty) {
            // Add access token to current custom headers
            customHeaders.updateValue(accessToken, forKey: "x-access-token")
        }
        
        return customHeaders
    }
    
    //MARK: Get API keys
    enum APIKeys {
        static let RESTful = Configuration.API.apiKey
        static let google = ""
        
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
    
    //MARK: Character counts
    enum Counts {
        static let passwordCount = 8
        static let nameMinimumCharCount = 2
    }
    
    //MARK: Static contents
    enum AppDetails {
        static let termsUrl       = ""
        static let privacyUrl     = ""
        static let forseUpdateURL = ""
    }
    
    enum Notification {
        static let NotiName = NSNotification.Name(rawValue: "NotiName")
    }
    
    //MARK: Categories
    static let categories = ["business","entertainment","general","health", "science", "sports", "technology"]
    static let languages = ["ae","ar","at","au","be","bg","br","ca","ch","cn","co","cu","cz","de","eg","fr","gb","gr","hk","hu","id","ie","il","in","it","jp","kr","lt","lv","ma","mx","my","ng","nl","no","nz","ph","pl","pt","ro","rs","ru","sa","se","sg","si","sk","th","tr","tw","ua","us","ve","za"]
    static let sortedTyps = ["relevancy", "popularity", "publishedAt"]
}

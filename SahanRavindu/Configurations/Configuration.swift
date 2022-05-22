//
//  Configuration.swift
//  SahanRavindu
//
//  Created by Sahan Ravindu on 2022-05-21.
//

import Foundation

class Configuration {
    
    static let `default`: Configuration = Configuration()
    
    enum Error: Swift.Error {
        case missingKey, invalidValue
    }
    
    func value<T>(for key: String) throws -> T where T: LosslessStringConvertible {
        guard let object = Bundle.main.object(forInfoDictionaryKey: key) else {
            throw Error.missingKey
        }
        
        switch object {
        case let value as T:
            return value
        case let string as String:
            guard let value = T(string) else { fallthrough }
            return value
        default:
            throw Error.invalidValue
        }
    }
}

extension Configuration {
    struct Keys {
        static let apiKey: String = "API_KEY"
        static let baseUrl: String = "BASE_URL"
    }
}

extension Configuration {
    struct API {
        static var apiKey: String {
            return try! Configuration.default.value(for: Configuration.Keys.apiKey)
        }
        static var baseUrl: String {
            return try! Configuration.default.value(for: Configuration.Keys.baseUrl)
        }
    }
}

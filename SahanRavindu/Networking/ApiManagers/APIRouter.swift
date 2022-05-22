//
//  APIRouter.swift
//  SahanRavindu
//
//  Created by Sahan Ravind on 11/2/20.
//
import Foundation
import Alamofire

protocol APIConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
}

enum APIRouter: APIConfiguration {
    // MARK: - Services
    case headlines(country: String, category: String, q: String, perpage: Int, page: Int)
    case everything(q: String, from: String, to: String, sortBy: String, perpage: Int, page: Int)
    
    // MARK: - HTTPMethod
    var method: HTTPMethod {
        switch self {
        case .headlines, .everything:
            return .get
        
        }
    }
    
    // MARK: - Path
    var path: String {
        switch self {
        case .headlines(let country, let category, let q, let perpage, let page):
            return "top-headlines?country=\(country)&category=\(category)&q=\(q)&perpage=\(perpage)&page=\(page)"
        case .everything(let q, let from, let to, let sortBy, let perpage, let page):
            return "everything?q=\(q)&from=\(from)&to=\(to)&sortBy=\(sortBy)&perpage=\(perpage)&page=\(page)"
        }
    }
    
    // MARK: - Parameters
    var parameters: Parameters? {
        switch self {
        case .headlines:
            return nil
        case .everything:
            return nil
        
        }
    }
    
    // MARK: - URLRequestConvertible
//    &apiKey=b82a7b37ea954439aa5ee8002aee1a6d"
    func asURLRequest() throws -> URLRequest {
        let urlString = (KConstant.getBaseURL() + path + "&apiKey=\(Configuration.API.apiKey)").addingPercentEncoding(withAllowedCharacters : CharacterSet.urlQueryAllowed) ?? path
        let url = try urlString.asURL()
        var urlRequest = URLRequest(url: url) //.appendingPathComponent(path))
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(KConstant.ContentType.json.rawValue, forHTTPHeaderField: KConstant.HTTPHeaderField.acceptType.rawValue)
        
        // Parameters
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        // NOTE:- Comment this after testing been completed
        printRequestData(urlRequest: urlRequest)
        
        return urlRequest
    }
    
    private func printRequestData(urlRequest: URLRequest) {
        print("**** URL:- \(urlRequest)")
        print("**** HTTP_METHOD:- \(method.rawValue)")
        print("**** HEADERS:- \(urlRequest.allHTTPHeaderFields ?? [:])")
        print("**** PARAMETERS:- \(parameters ?? [:])")
    }
}

//+ Configuration.API.apiKey

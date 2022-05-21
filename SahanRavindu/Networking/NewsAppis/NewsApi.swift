//
//  NewsApi.swift
//  SahanRavindu
//
//  Created by Sahan Ravindu on 2022-05-21.
//

import Foundation
import Alamofire

final class NewsApi {
    static let shared = NewsApi()
    
    func getHeadings(q: String, from: String, to: String, sortBy: String, perpage: Int, page: Int,  completion:@escaping (Result< News, AFError>, Data)-> Void) {
        APIClient.performRequest(route: APIRouter.everything(
            q: q,
            from: from,
            to: to,
            sortBy: sortBy,
            perpage: perpage,
            page: page
        ), completion: completion)
    }
    
    func getEverything(country: String, category: String, q: String, perpage: Int, page: Int,  completion:@escaping (Result< News, AFError>, Data)-> Void) {
        APIClient.performRequest(route: APIRouter.headlines(
            country: country,
            category: category,
            q: q,
            perpage: perpage,
            page: page
        ), completion: completion)
    }
    
}

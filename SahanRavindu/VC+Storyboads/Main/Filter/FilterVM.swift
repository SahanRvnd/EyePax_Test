//
//  FilterVM.swift
//  SahanRavindu
//
//  Created by Sahan Ravindu on 2022-05-22.
//

import Foundation

class FilterVM: BaseVM {
    var everithingPage = 1
    var everything: News?
    var remender: Int = 0
    var cateoryHeader = NewsItem(title: [], news: [], section: "1")
    var selectedCategory: String = ""
    var q: String = ""
    var categoryList: [String] = []
    var filterModel: Filter?
 
    func getEverything(isLoardMore: Bool = false, country: String, category: String, q: String, perpage: Int, page: Int, completion: @escaping CompletionHandler) {
        guard NetworkReachability.isConnectedToNetwork() else {
            completion(false, 503, .InternetConnectionOffline)
            return
        }
        
        NewsApi.shared.getEverything(country: country, category: category, q: q, perpage: perpage, page: page, completion:  { [weak self] (result, data)  in
            switch result {
            case .success(let responseModel):
                //                print(true, responseModel)
                self?.everything = nil
                self?.everything = responseModel
                
                if self?.everything?.articles?.count ?? 0 > 0 {
                    if isLoardMore {
                        self?.cateoryHeader.news?.append(contentsOf: self?.everything?.articles ?? [])
                    } else {
                        self?.cateoryHeader.news = self?.everything?.articles ?? []
                    }
                    
                    completion(true, 200, "")
                } else {
                    completion(false, 200, "There are no news reguarding this filters")
                }
                
            case .failure(let error):
                print(false, "Log in failed \(error.localizedDescription)")
                completion(true, 401, "Log in failed \(error.localizedDescription)")
            }
        })
        
    }
}

struct Filter {
    var language: String?
    var sortBy: String?
}

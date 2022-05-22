//
//  SeaAllVM.swift
//  SahanRavindu
//
//  Created by Sahan Ravindu on 2022-05-22.
//

import Foundation

class SeaAllVM: BaseVM {
    var headlinePage = 1
    var headline: News?
    var remender: Int = 0
    var q: String = ""
    var headlines: [Article]?
 
    func getHeadlines(isLoardMore: Bool = false, q: String, from: String, to: String, sortBy: String, perpage: Int, page: Int, completion: @escaping CompletionHandler) {
        guard NetworkReachability.isConnectedToNetwork() else {
            completion(false, 503, .InternetConnectionOffline)
            return
        }
        
        NewsApi.shared.getHeadings(q: q, from: from, to: to, sortBy: sortBy, perpage: perpage, page: page, completion:  { [weak self] (result, data)  in
            switch result {
            case .success(let responseModel):
                //                print(true, responseModel)
                self?.headline = nil
                self?.headline = responseModel
                
                if self?.headline?.articles?.count ?? 0 > 0 {
                    if isLoardMore {
                        self?.headlines?.append(contentsOf: self?.headline?.articles ?? [])
                    } else {
                        self?.headlines = self?.headline?.articles ?? []
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


//
//  HomeVC+Services.swift
//  SahanRavindu
//
//  Created by Sahan Ravindu on 2022-05-21.
//

import Foundation

extension HomeVC {
    //MARK:Get Headlines
    func getHeadlines(isLoardMore: Bool = false, q: String, from: String, to: String, sortBy: String, perpage: Int, page: Int) {
        self.view.endEditing(true)
        showActivityIndicator()
        vm.getHeadlines(isLoardMore: isLoardMore, q: q, from: from, to: to, sortBy: sortBy, perpage: perpage, page: page) { [weak self] (success, code, message) in
            self?.hideActivityIndicator()
            if success {
                self?.listAdded()
            } else {
                guard let vc = self else {
                    return
                }
                AlertProvider(vc: vc).showAlert(title: .Warning, message: message, action: AlertAction(title: .Ok))
            }
        }
    }
    
    //MARK:Get Everything
    func getEverything(isLoardMore: Bool = false, country: String, category: String, q: String, perpage: Int, page: Int) {
        self.view.endEditing(true)
        showActivityIndicator()
        vm.getEverything(isLoardMore: isLoardMore, country: country, category: category, q: q, perpage: perpage, page: page) { [weak self] (success, code, message) in
            self?.hideActivityIndicator()
            if success {
                self?.listAdded()
            } else {
                guard let vc = self else {
                    return
                }
                AlertProvider(vc: vc).showAlert(title: .Warning, message: message, action: AlertAction(title: .Ok))
            }
        }
    }
    
    func listAdded() {
        self.tableView.reloadData()
    }
}

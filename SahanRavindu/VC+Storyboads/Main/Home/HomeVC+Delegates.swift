//
//  HomeVC+Delegates.swift
//  SahanRavindu
//
//  Created by Sahan Ravindu on 2022-05-21.
//

import Foundation
import UIKit

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.vm.newsItems.count > 0 {
            return  self.vm.newsItems.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.vm.newsItems.count > 0 {
            if section == 0 {
                return 1
            } else {
                return self.vm.newsItems[section].news?.count ?? 0
            }
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        if self.vm.newsItems.count >= section {
            
            let headerItem = self.vm.newsItems[section].title
            
            
            if section == 0 {
                let header = Bundle.main.loadNibNamed(titleHeader, owner: self.view, options: nil)?.first as! NewsHeaderView
                header.configureHeader(with: headerItem ?? [])
                return header
            } else {
                let header = Bundle.main.loadNibNamed(headerCtegoryView, owner: self.view, options: nil)?.first as! HeaderCategoryView
                header.configureHeader(with: KConstant.categories, selected: vm.selectedCategory)
                header.cellTap = { [weak self] category in
                    self?.selectCategory(category: category)
                }
                return header
            }
        }
        
        return UIView()
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        let item = self.vm.newsItems[section]
        
        if item.news?.count ?? 0 > 0 {
            return 54
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if self.vm.newsItems.count >= indexPath.section {
            if indexPath.section == 0  {
                return self.tableView.frame.width/3*2
            } else  {
                return self.tableView.frame.width/3*1.2
            }
        }
        return 0
    }
    
    func selectCategory(category: String) {
        vm.selectedCategory = category
        getEverything(country: "us", category: vm.selectedCategory, q: "", perpage: 20, page: 1)
    }
}

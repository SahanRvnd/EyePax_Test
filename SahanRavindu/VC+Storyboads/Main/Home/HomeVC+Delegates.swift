//
//  HomeVC+Delegates.swift
//  SahanRavindu
//
//  Created by Sahan Ravindu on 2022-05-21.
//

import Foundation
import UIKit
import RealmSwift

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
            if self.vm.newsItems[section].section == "0" {
                return 1
            } else {
                if let count = self.vm.newsItems[section].news?.count {
                    vm.remender = count % 20
                }
                return self.vm.newsItems[section].news?.count ?? 0
            }
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if vm.newsItems[indexPath.section].news?.count ?? 0 > 0 {
            let sectionItems = vm.newsItems[indexPath.section].title
            let newsItems = vm.newsItems[indexPath.section].news ?? []
            if self.vm.newsItems[indexPath.section].section == "0" {
                if let cell = tableView.dequeueReusableCell(withIdentifier: headlineCellIdentifire) as? HeadlineTblCell {
                    
                    cell.cellConfiguration(with: newsItems)
                    cell.cellTap = { [weak self] selectedNews in
                        self?.selectArticalAndRedirectToDetail(artical: selectedNews)
                    }
                    
                    return cell
                }
            } else {
                if let cell = tableView.dequeueReusableCell(withIdentifier: newsCellIdentifire) as? NewsTblCell {
                    
                    cell.cellConfiguration(with: newsItems[indexPath.row])
                    
                    return cell
                }
            }
            
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        if self.vm.newsItems.count >= section {
            
            let headerItem = self.vm.newsItems[section].title
            
            
            if self.vm.newsItems[section].section == "0" {
                let header = Bundle.main.loadNibNamed(titleHeader, owner: self.view, options: nil)?.first as! NewsHeaderView
                header.configureHeader(with: headerItem ?? [])
                header.cellTap = { [weak self] in
                    self?.filterView()
                }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if vm.newsItems.count > 0 {
            if vm.newsItems[indexPath.section].section != "0" {
                if let item = vm.newsItems[indexPath.section].news?[indexPath.row] {
                    selectArticalAndRedirectToDetail(artical: item)
                }
            }
        }
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
            if self.vm.newsItems[indexPath.section].section == "0"  {
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
    
    func selectArticalAndRedirectToDetail(artical: Article) {
        let vm = DetailVM(artical: artical)
        ApplicationServiceProvider.shared.pushToViewController(in: .Main, for: .DetailVC, from: self, data: vm)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let shouldRequestForRemaingEpisodes = offsetY > contentHeight - scrollView.frame.size.height
        if shouldLoadMore() && shouldRequestForRemaingEpisodes {
            vm.everithingPage = vm.everithingPage + 1
            getEverything(isLoardMore: true, country: "us", category: vm.selectedCategory, q: vm.q, perpage: 20, page: vm.everithingPage)
            
        }
    }
    
    func shouldLoadMore()-> Bool {
        if vm.newsItems.count > 1 {
            
            if vm.newsItems[1].news?.count ?? 0 < 20 || vm.remender != 0 {
                return false
            } else {
                return true
            }
        }
        return false
    }
    
    func filterView() {
        ApplicationServiceProvider.shared.pushToViewController(in: .Main, for: .SeaAllVC, from: self, data: vm)
    }
}

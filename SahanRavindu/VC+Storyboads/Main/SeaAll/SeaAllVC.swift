//
//  SeaAllVC.swift
//  SahanRavindu
//
//  Created by Sahan Ravindu on 2022-05-22.
//

import UIKit

class SeaAllVC: BaseVC {
    
    //MARK: Variables
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Variables
    let vm = SeaAllVM()
    let seeAllTblCell          = "SeeAllTblCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setDelegate()
        registerCells()
        fetchData()
        addPullToRefreshToScrollView()
        setupTableView(with: tableView)
//        self.toggleNavigationBarVisibility(.hide)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        self.toggleNavigationBarVisibility(.show)
    }

    func setupUI() {
        self.view.endEditing(true)
    }
    
    func setDelegate() {
        tableView.delegate           = self
        tableView.dataSource         = self
    }
    
    func registerCells() {
        tableView.register(UINib(nibName: seeAllTblCell, bundle: nil), forCellReuseIdentifier: seeAllTblCell)
    }
    
    func addPullToRefreshToScrollView() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        
        tableView.refreshControl = refreshControl
    }
    
    @objc func pullToRefresh(refreshControl: UIRefreshControl) {
        print("Refreshing Did Finish")
        fetchData()
        // somewhere in your code you might need to call:
        refreshControl.endRefreshing()
    }
    
    func fetchData() {
        vm.headlinePage = 1
        getHeadlines(q: "all", from: "", to: "", sortBy: "popularity", perpage: 20, page: 1)
    }
    

}

extension SeaAllVC: UITableViewDelegate, UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 0
//    }
//
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.vm.headlines?.count ?? 0 > 0 {
            if let count = vm.headlines?.count {
                vm.remender = count % 20
            }
            return vm.headlines?.count ?? 0
            
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: seeAllTblCell) as? SeeAllTblCell {
            if let item = vm.headlines?[indexPath.row] {
                cell.cellconfigurations(with: item)
            }
            
            return cell
        }
        return UITableViewCell()
    }
    
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if vm.headlines?.count ?? 0 > 0 {
            if let item = vm.headlines?[indexPath.row] {
                selectArticalAndRedirectToDetail(artical: item)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 54
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.width/3*2.5
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
            vm.headlinePage = vm.headlinePage + 1
            getHeadlines(isLoardMore: true,q: "all", from: "", to: "", sortBy: "popularity", perpage: 20, page: vm.headlinePage)
            
        }
    }
    
    func shouldLoadMore()-> Bool {
        
        if vm.headlines?.count ?? 0 < 20 || vm.remender != 0 {
            return false
        } else {
            return true
        }
    }
    
    func openFilterView() {
        ApplicationServiceProvider.shared.presentViewController(in: .Main, for: .FilterOptionVC, from: self, style: .overCurrentContext)
    }
    
}

extension SeaAllVC {
    //MARK:Get Everything
    func getHeadlines(isLoardMore: Bool = false, q: String, from: String, to: String, sortBy: String, perpage: Int, page: Int) {
        self.view.endEditing(true)
        showActivityIndicator()
        vm.getHeadlines(isLoardMore: isLoardMore,q: q, from: from, to: to, sortBy: sortBy, perpage: perpage, page: page) { [weak self] (success, code, message) in
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


//
//  MainVC.swift
//  SahanRavindu
//
//  Created by Sahan Ravindu on 2021-01-29.
//

import UIKit
import RxCocoa
import RxSwift

class HomeVC: BaseVC {
    
    //MARK: Outlets
    @IBOutlet weak var searchView           : UIView!
    @IBOutlet weak var searchTxtView        : UITextField!
    @IBOutlet weak var tableView            : UITableView!
    
    
    //MARK: Variables
    let vm = HomeVM()
    let titleHeader                 = "NewsHeaderView"
    let headerCtegoryView           = "HeaderCategoryView"
    let headlineCellIdentifire      = "HeadlineTblCell"
    let newsCellIdentifire          = "NewsTblCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setDelegate()
        registerCells()
        fetchData()
        addPullToRefreshToScrollView()
    }
    
    @IBAction func didClearSearch(_ sender: Any) {
        if searchTxtView.text == "" {
            fetchData()
        }
    }
    
    
    func setupUI() {
        searchView.addLayerEffects(with: UIColor.lightGray, borderWidth: 1.0, cornerRadius: 22)
        searchTxtView.setPlaceHolder(placeholder: "Search", color: UIColor.gray)
        setupTableView(with: tableView)
        self.view.endEditing(true)
    }
    
    func setDelegate() {
        tableView.delegate           = self
        tableView.dataSource         = self
        setDelegatesForTextEditors(tfs: [searchTxtView])
    }
    
    func registerCells() {
        tableView.register(UINib(nibName: titleHeader, bundle: nil), forHeaderFooterViewReuseIdentifier: titleHeader)
        tableView.register(UINib(nibName: headerCtegoryView, bundle: nil), forHeaderFooterViewReuseIdentifier: headerCtegoryView)
        
        tableView.register(UINib(nibName: headlineCellIdentifire, bundle: nil), forCellReuseIdentifier: headlineCellIdentifire)
        tableView.register(UINib(nibName: newsCellIdentifire, bundle: nil), forCellReuseIdentifier: newsCellIdentifire)
    }
    
    func fetchData() {
        vm.headlinePage = 1
        vm.everithingPage = 1
        vm.selectedCategory = KConstant.categories.count > 0 ? KConstant.categories[0] : ""
        getHeadlines(q: "all", from: "", to: "", sortBy: "popularity", perpage: 20, page: 1)
        getEverything(country: "us", category: vm.selectedCategory, q: vm.q, perpage: 20, page: 1)
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
    
}

extension HomeVC {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == searchTxtView {
            self.view.endEditing(true)
            vm.q = searchTxtView.text ?? ""
            getHeadlines(q: vm.q, from: "", to: "", sortBy: "popularity", perpage: 20, page: 1)
            getEverything(country: "us", category: vm.selectedCategory, q: vm.q, perpage: 20, page: 1)
        }
        return true
    }
}

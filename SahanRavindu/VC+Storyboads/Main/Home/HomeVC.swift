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
    let headlineCellIdentifire      = "VideoTBLHeader"
    let newsCellIdentifire          = "VideoCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setDelegate()
        registerCells()
        fetchData()
    }
    
    func setupUI() {
        searchView.addLayerEffects(with: UIColor.lightGray, borderWidth: 1.0, cornerRadius: 22)
        searchTxtView.setPlaceHolder(placeholder: "Search", color: UIColor.gray)
        setupTableView(with: tableView)
    }
    
    func setDelegate() {
        tableView.delegate           = self
        tableView.dataSource         = self
    }
    
    func registerCells() {
        tableView.register(UINib(nibName: titleHeader, bundle: nil), forHeaderFooterViewReuseIdentifier: titleHeader)
        tableView.register(UINib(nibName: headerCtegoryView, bundle: nil), forHeaderFooterViewReuseIdentifier: headerCtegoryView)
    }
    
    func fetchData() {
        vm.selectedCategory = KConstant.categories.count > 0 ? KConstant.categories[0] : ""
        getHeadlines(q: "all", from: "", to: "", sortBy: "popularity", perpage: 20, page: 1)
        getEverything(country: "us", category: vm.selectedCategory, q: "", perpage: 20, page: 1)
    }
    
}


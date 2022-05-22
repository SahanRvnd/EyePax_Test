//
//  FilterVC.swift
//  SahanRavindu
//
//  Created by Sahan Ravindu on 2022-05-22.
//

import UIKit

class FilterVC: BaseVC {
    
    //MARK: Variables
    @IBOutlet weak var searchView           : UIView!
    @IBOutlet weak var searchTxtView        : UITextField!
    @IBOutlet weak var tableView            : UITableView!
    
    //MARK: Variables
    let vm = FilterVM()
    let headerCtegoryView           = "HeaderCategoryView"
    let newsCellIdentifire          = "NewsTblCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setDelegate()
        registerCells()
        addPullToRefreshToScrollView()
        fetchData()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didClearSearchText(_ sender: Any) {
        if searchTxtView.text == "" {
            fetchData()
        }
    }
    
    func setupUI() {
        searchView.addLayerEffects(with: UIColor.lightGray, borderWidth: 1.0, cornerRadius: 22)
        searchTxtView.setPlaceHolder(placeholder: "Search", color: UIColor.gray)
        setupTableView(with: tableView)
        vm.categoryList.append(contentsOf: KConstant.categories)
        self.view.endEditing(true)
    }
    
    func setDelegate() {
        tableView.delegate           = self
        tableView.dataSource         = self
        setDelegatesForTextEditors(tfs: [searchTxtView])
    }
    
    func registerCells() {
        tableView.register(UINib(nibName: headerCtegoryView, bundle: nil), forHeaderFooterViewReuseIdentifier: headerCtegoryView)
        tableView.register(UINib(nibName: newsCellIdentifire, bundle: nil), forCellReuseIdentifier: newsCellIdentifire)
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
        vm.everithingPage = 1
        vm.selectedCategory = KConstant.categories.count > 0 ? KConstant.categories[0] : ""
        getEverything(country: "us", category: vm.selectedCategory, q: vm.q, perpage: 20, page: 1)
    }
    
    
}

extension FilterVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.vm.cateoryHeader.news?.count ?? 0 > 0 {
            if let count = self.vm.cateoryHeader.news?.count {
                vm.remender = count % 20
            }
            return self.vm.cateoryHeader.news?.count ?? 0
            
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: newsCellIdentifire) as? NewsTblCell {
            if let item = vm.cateoryHeader.news?[indexPath.row] {
                cell.cellConfiguration(with: item)
            }
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if let header = (Bundle.main.loadNibNamed(headerCtegoryView, owner: self.view, options: nil)?.first as? HeaderCategoryView) {
            header.configureHeader(with: vm.categoryList, selected: vm.selectedCategory)
            header.cellTap = { [weak self] category in
                self?.selectCategory(category: category)
                
            }
            return header
        }
        
        
        return UIView()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if vm.cateoryHeader.news?.count ?? 0 > 0 {
            if let item = vm.cateoryHeader.news?[indexPath.row] {
                selectArticalAndRedirectToDetail(artical: item)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 54
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return self.tableView.frame.width/3*1.2
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
        
        if vm.cateoryHeader.news?.count ?? 0 < 20 || vm.remender != 0 {
            return false
        } else {
            return true
        }
    }
    
    func openFilterView() {
        ApplicationServiceProvider.shared.presentViewController(in: .Main, for: .FilterOptionVC, from: self, style: .overCurrentContext)
    }
    
}

extension FilterVC {
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

extension FilterVC {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == searchTxtView {
            self.view.endEditing(true)
            vm.q = searchTxtView.text ?? ""
            getEverything(country: "us", category: vm.selectedCategory, q: vm.q, perpage: 20, page: 1)
        }
        return true
    }
}

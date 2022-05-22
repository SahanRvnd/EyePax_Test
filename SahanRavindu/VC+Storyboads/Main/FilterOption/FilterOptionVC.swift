//
//  FilterOptionVCViewController.swift
//  SahanRavindu
//
//  Created by Sahan Ravindu on 2022-05-22.
//

import UIKit

class FilterOptionVC: BaseVC {
    
    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
//    MARK: Variables
    let vm = FilterOptionVM()
    var language: String = ""
    var sortType: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setDelagates()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func setUpUI() {
        let language = FilterOptionData(title: "Language", itemList: KConstant.languages)
        let sortby = FilterOptionData(title: "Sort By", itemList: KConstant.sortedTyps)
        vm.filterOptions = [sortby, language]
        
    }

    func setDelagates() {
        tableView.delegate = self
        tableView.dataSource = self
    }

}

extension FilterOptionVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.filterOptions?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FilterOptionTblCell", for: indexPath) as? FilterOptionTblCell {
            if let _filter = vm.filterOptions?[indexPath.row] {
            cell.cellFonfiguration(with: _filter)
            }
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 82
    }
    
    
}

class FilterOptionTblCell: UITableViewCell {
    
//    MARK: Outlets
    @IBOutlet weak var sortTypeLB: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: Variables
    let sliderSectionInsets     = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    let categoryCell            = "CategoryCell"
    let filterCell              = "FilterCLCell"
    var categoryList: [String]  = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    var select: String              = ""
    var cellTap                     : ((String)->())?
    var filterSelect: Bool          = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func prepareForReuse() {
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layoutIfNeeded()
    }
    
    func setupUI() {
        collectionView.delegate   = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: categoryCell, bundle: .main), forCellWithReuseIdentifier: categoryCell)
        collectionView.register(UINib(nibName: filterCell, bundle: .main), forCellWithReuseIdentifier: filterCell)
    }
    
    func cellFonfiguration(with model: FilterOptionData) {
        sortTypeLB.text = model.title ?? ""
        categoryList = model.itemList ?? []
        self.layoutIfNeeded()
    }
}

extension FilterOptionTblCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        switch collectionView {
        case collectionView:
            return 1
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case collectionView:
            return categoryList.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if categoryList[indexPath.row] != "Filter" {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryCell, for: indexPath) as? CategoryCell {
                let item = categoryList[indexPath.row]
                let isSelect:Bool = (item == select) ? true : false
                cell.cellconfigurations(model: item, isSelec: isSelect)
                
                return cell
            }
        } else {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: filterCell, for: indexPath) as? FilterCLCell {
                cell.cellconfigurations(isSelec: filterSelect)
                
                return cell
            }
        }
        
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let item = categoryList[indexPath.row]
        if item == "Filter" {
            return CGSize(width: 120, height: collectionView.bounds.height-10)
        } else {
            let itemSize = item.size(withAttributes: [
                NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 20)
            ])
            return CGSize(width: itemSize.width + 20, height: collectionView.bounds.height-10)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        switch collectionView {
        case collectionView:
            return sliderSectionInsets
        default:
            return UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if categoryList.count > 0 {
            let item = categoryList[indexPath.row]
            cellTap?(item)
        }
    }
    
}

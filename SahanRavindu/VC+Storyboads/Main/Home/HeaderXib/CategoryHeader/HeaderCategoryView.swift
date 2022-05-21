//
//  HeaderCategoryView.swift
//  SahanRavindu
//
//  Created by Sahan Ravindu on 2022-05-21.
//

import UIKit
import SwiftUI

class HeaderCategoryView: UIView {
    
    //MARK: Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: Variable
    let sliderSectionInsets     = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    let categoryCell    = "CategoryCell"
    var categoryList: [String] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    var select: String = ""
    var cellTap                     : ((String)->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layoutIfNeeded()
    }
    
    func setupUI() {
        collectionView.delegate   = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: categoryCell, bundle: .main), forCellWithReuseIdentifier: categoryCell)
    }
    
    func configureHeader(with model: [String], selected: String) {
        
        categoryList = model
        select = selected
        self.layoutIfNeeded()
    }
    
    
}

extension HeaderCategoryView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
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
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryCell, for: indexPath) as? CategoryCell {
            let item = categoryList[indexPath.row]
            let isSelect:Bool = (item == select) ? true : false
            cell.cellconfigurations(model: item, isSelec: isSelect)
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let item = categoryList[indexPath.row]
        let itemSize = item.size(withAttributes: [
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 20)
        ])
        return CGSize(width: itemSize.width + 20, height: collectionView.bounds.height-10)
        
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

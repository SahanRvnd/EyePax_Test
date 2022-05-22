//
//  NewsHeaderView.swift
//  SahanRavindu
//
//  Created by Sahan Ravindu on 2022-05-21.
//

import UIKit

class NewsHeaderView: UIView {
    
    @IBOutlet weak var titleStack: UIStackView!
    
    var isList                      : Bool = false
    var categoryList                : [String] = []
    var cellTap                     : (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    @IBAction func didClickSeeAll(_ sender: Any) {
        cellTap?()
    }
    
    func setupUI() {
    }
    
    func configureHeader(with model: [String]) {
        
       
        isList = model.count > 1 ? true : false
        categoryList = model
        setupUI()
        self.layoutIfNeeded()
        
    }
    
    
}

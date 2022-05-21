//
//  CategoryCell.swift
//  SahanRavindu
//
//  Created by Sahan Ravindu on 2022-05-21.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var txtLabel: UILabel!
    
    var isSelec: Bool = false {
        didSet {
            selected()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    override func prepareForReuse() {
        txtLabel.text = ""
        txtLabel.textColor = .black
    }
    
    func setupUI() {
        txtLabel.textColor = .black
        mainView.addLayerEffects(with: .lightGray, borderWidth: 1, cornerRadius: self.mainView.bounds.height/2)
    }
    
    func selected() {
        mainView.backgroundColor = isSelec ? UIColor(named: "Primary") : UIColor.white
        txtLabel.textColor = isSelec ? .white : .black
    }

    func cellconfigurations(model: String, isSelec: Bool) {
        txtLabel.text = model
        self.isSelec = isSelec
    }
}

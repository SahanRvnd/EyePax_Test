//
//  FilterCLCell.swift
//  SahanRavindu
//
//  Created by Sahan Ravindu on 2022-05-22.
//

import UIKit

class FilterCLCell: UICollectionViewCell {
    
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var filterLB: UILabel!
    @IBOutlet weak var filterImgView: UIImageView!
    
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
        filterImgView.image = UIImage(named: "filter")
        filterLB.textColor = .black
    }
    
    func setupUI() {
        filterLB.textColor = .black
        mainView.addLayerEffects(with: .lightGray, borderWidth: 1, cornerRadius: self.mainView.bounds.height/2)
    }
    
    func selected() {
        mainView.backgroundColor = isSelec ? UIColor(named: "Primary") : UIColor.white
        filterLB.textColor = isSelec ? .white : .black
        filterImgView.image = isSelec ? UIImage(named: "filterActive"): UIImage(named: "filter")
    }

    func cellconfigurations(isSelec: Bool) {
        self.isSelec = isSelec
    }

}

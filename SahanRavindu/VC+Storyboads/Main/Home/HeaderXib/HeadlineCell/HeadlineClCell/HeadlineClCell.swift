//
//  HeadlineClCell.swift
//  SahanRavindu
//
//  Created by Sahan Ravindu on 2022-05-22.
//

import UIKit

class HeadlineClCell: UICollectionViewCell {

    //MARK: Outlets
    @IBOutlet weak var mainView         : UIView!
    @IBOutlet weak var imageView        : UIImageView!
    @IBOutlet weak var authorLB         : UILabel!
    @IBOutlet weak var headlineLB       : UILabel!
    @IBOutlet weak var descriptionLB    : UILabel!
    @IBOutlet weak var gradientView     : UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func prepareForReuse() {
        imageView.image = UIImage()
        authorLB.text = ""
        headlineLB.text = ""
        descriptionLB.text = ""
    }
    
    func setupUI() {
        mainView.addLayerEffects(cornerRadius: 10)
        imageView.addLayerEffects(cornerRadius: 10)
        self.layoutIfNeeded()
    }
    
    func cellconfiguration(with model: Article) {
        imageView.setImageWithUrl(model.urlToImage ?? "")
        authorLB.text = "by \(model.author ?? "")"
        headlineLB.text = model.title
        descriptionLB.text = model.articleDescription
//        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
//            self.gradientView.applyGradient(isTopBottom: true, colorArray: [UIColor.clear, UIColor.lightGray, UIColor.gray], cornerRadious: 10 )
//        }
        self.layoutIfNeeded()
    }

}

//
//  SeeAllTblCell.swift
//  SahanRavindu
//
//  Created by Sahan Ravindu on 2022-05-22.
//

import UIKit

class SeeAllTblCell: UITableViewCell {
    
    //MARK: Outlets
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var dateLB: UILabel!
    @IBOutlet weak var tittleLB: UILabel!
    @IBOutlet weak var descriptionLB: UILabel!
    @IBOutlet weak var autherLB: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        imgView.image = UIImage()
        dateLB.text = ""
        tittleLB.text = ""
        descriptionLB.text = ""
        autherLB.text = ""
    }
    
    func setupUI() {
        imgView.addLayerEffects(cornerRadius: 10)
    }
    
    func cellconfigurations(with model: Article) {
        imgView.setImageWithUrl(model.urlToImage ?? "")
        dateLB.text = model.publishedAt?.convertDateTimeToDate(format: "EEEE, dd MMM yyyy")
        tittleLB.text = model.title
        descriptionLB.text = model.articleDescription
        autherLB.text = "Published by \(model.author ?? "")"
    }
    
}

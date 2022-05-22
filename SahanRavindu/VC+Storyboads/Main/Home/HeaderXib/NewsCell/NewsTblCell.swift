//
//  NewsTblCell.swift
//  SahanRavindu
//
//  Created by Sahan Ravindu on 2022-05-22.
//

import UIKit

class NewsTblCell: UITableViewCell {
    
    //MARK: Outlets
    @IBOutlet weak var mainView         : UIView!
    @IBOutlet weak var imgView          : UIImageView!
    @IBOutlet weak var autherLB         : UILabel!
    @IBOutlet weak var dateLB           : UILabel!
    @IBOutlet weak var headlineLB       : UILabel!
    @IBOutlet weak var gradientView     : UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        imgView.image   = UIImage()
        autherLB.text   = ""
        dateLB.text     = ""
        headlineLB.text = ""
    }
    
    func setupUI() {
        mainView.addLayerEffects(cornerRadius: 10)
        imgView.addLayerEffects(cornerRadius: 10)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            self.gradientView.applyGradient(isTopBottom: true, colorArray: [UIColor.clear, UIColor.lightGray, UIColor.gray], cornerRadious: 10 )
        }
        gradientView.addLayerEffects(cornerRadius: 10)
    }
    
    func cellConfiguration(with model: Article) {
        imgView.setImageWithUrl(model.urlToImage ?? "")
        autherLB.text   = model.author
        headlineLB.text = model.title
        dateLB.text     = model.publishedAt?.convertDateTimeToDate()
        self.layoutIfNeeded()
    }
    
}

//
//  DetailVC.swift
//  SahanRavindu
//
//  Created by Sahan Ravindu on 2022-05-22.
//

import UIKit

class DetailVC: BaseVC {
    
    //MARK: Outlets
    @IBOutlet weak var backButtonImg            : UIImageView!
    
    @IBOutlet weak var imgView                  : UIImageView!
    @IBOutlet weak var imageBackView            : UIView!
    
    @IBOutlet weak var titleDataGradientView    : UIView!
    
    @IBOutlet weak var dateLB                   : UILabel!
    @IBOutlet weak var headLineLB               : UILabel!
    @IBOutlet weak var authorLB                 : UILabel!
    @IBOutlet weak var contentLB                : UILabel!
    
    //MARK: Variables
    var vm: DetailVM = DetailVM(artical: Article())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.toggleNavigationBarVisibility(.hide)
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.toggleNavigationBarVisibility(.show)
    }
    
    @IBAction func didClickOnBackButton(_ sender: Any) {
        self.goBack()
    }
    
    func setupUI() {
        imageBackView.layer.cornerRadius = 20
        imageBackView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        titleDataGradientView.addLayerEffects(cornerRadius: 10)
    }
    
    func setData() {
        let _artical = vm.artical
        imgView.setImageWithUrl(_artical.urlToImage ?? "")
        
        dateLB.text = _artical.publishedAt?.convertDateTimeToDate(format: "EEEE, MMM d, yyyy")
        headLineLB.text = _artical.title
        authorLB.text = "Published by \(_artical.author ?? "")"
        contentLB.text = _artical.articleDescription
        
        
    }

}

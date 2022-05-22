//
//  DetailVC.swift
//  SahanRavindu
//
//  Created by Sahan Ravindu on 2022-05-22.
//

import UIKit

class DetailVC: BaseVC {
    
    //MARK: Outlets
    @IBOutlet weak var backButtonImg: UIImageView!
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var imageBackView: UIView!
    
    @IBOutlet weak var titleDataGradientView: UIView!
    
    @IBOutlet weak var dateLB: UILabel!
    @IBOutlet weak var headLineLB: UILabel!
    @IBOutlet weak var authorLB: UILabel!
    @IBOutlet weak var contentLB: UILabel!
    
    //MARK: Variables
    var vm: DetailVM = DetailVM(artical: Article())
    let text = "What is Lorem Ipsum?Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.Why do we use it?It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).Where does it come from?Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of de Finibus Bonorum et Malorum (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, Lorem ipsum dolor sit amet.., comes from a line in section 1.10.32.The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from de Finibus Bonorum et Malorum by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham."
//    convenience init(vm: DetailVM) {
//        self.init(vm: vm)
//        self.vm = vm
//
//    }
//
//    required init?(coder: NSCoder) {
////        fatalError("init(coder:) has not been implemented")
//    }
    
    
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

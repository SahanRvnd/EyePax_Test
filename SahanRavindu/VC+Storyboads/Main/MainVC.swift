//
//  MainVC.swift
//  SahanRavindu
//
//  Created by Sahan Ravindu on 2021-01-29.
//

import UIKit
import RxCocoa
import RxSwift

class MainVC: BaseVC {
    @IBOutlet weak var btnNext: UIButton!
    
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addObservers()
        // Do any additional setup after loading the view.
    }

    func addObservers() {
        btnNext.rx.tap.subscribe(onNext: { [weak self] _ in
//            self?.navigate()
        }).disposed(by: bag)
    }

    @IBAction func didClickLogOut(_ sender: Any) {
        
        logout()
    }
}


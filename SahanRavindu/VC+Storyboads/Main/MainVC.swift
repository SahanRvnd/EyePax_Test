//
//  MainVC.swift
//  SahanRavindu
//
//  Created by Sahan Ravindu on 2021-01-29.
//

import UIKit
import RxCocoa
import RxSwift

class MainVC: UIViewController {
    
    @IBOutlet weak var btnNext: UIButton!
    
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addObservers()
        // Do any additional setup after loading the view.
    }

    func addObservers() {
        btnNext.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.navigate()
        }).disposed(by: bag)
    }
    
    func navigate() {
        ApplicationServiceProvider.shared.pushToViewController(in: .Main, for: .AuthNC, from: self)
    }

}


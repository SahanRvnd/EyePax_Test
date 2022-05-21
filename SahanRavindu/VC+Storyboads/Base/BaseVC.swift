//
//  BaseVC.swift
//  SahanRavindu
//
//  Created by Sahan Ravindu on 2022-05-21.
//

import UIKit

class BaseVC: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func toggleNavBar(isHidden: Bool = false, animated: Bool = true) {
        navigationController?.setNavigationBarHidden(isHidden, animated: animated)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func setDelegatesForTextEditors(tfs: [UITextField] = [], tvs: [UITextView] = []) {
        tfs.forEach({ tf in
            tf.delegate = self
        })
        
        tvs.forEach({ tv in
            tv.delegate = self
        })
    }
    
    func logout() {
        UserDefaultsManager.setLogedInUser(false)
            // Direct to login root
        ApplicationServiceProvider.shared.directToPath(in: .Auth, for: .SignInVC, from: self)
    }

}

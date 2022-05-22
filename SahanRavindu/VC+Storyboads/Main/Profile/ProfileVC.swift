//
//  ProfileVC.swift
//  SahanRavindu
//
//  Created by Sahan Ravindu on 2022-05-22.
//

import UIKit

class ProfileVC: BaseVC {

    @IBOutlet weak var profileLmgView       : UIImageView!
    @IBOutlet weak var greatingLB           : UILabel!
    @IBOutlet weak var btnLogOut            : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setData()
    }
    
    @IBAction func didClickLogOut(_ sender: Any) {
        didClickLogOut()
    }
    
    func setupUI() {
        profileLmgView.addLayerEffects(cornerRadius: profileLmgView.bounds.height/2)
        btnLogOut.backgroundColor = .lightGray
        btnLogOut.addLayerEffects(cornerRadius: btnLogOut.bounds.height/2)
    }
    
    func setData() {
        greatingLB.text = "Hi \(LocalUser.current()?.fullName ?? "User")"
        profileLmgView.setImageWithUrl("https://cdn1.vectorstock.com/i/1000x1000/23/70/man-avatar-icon-flat-vector-19152370.jpg")
    }
    
    func didClickLogOut() {
        AlertProvider(vc: self).showAlertWithActions(title: .Warning, message: .LogoutConfirmation, actions: [AlertAction(title: .Yes, style: .destructive), AlertAction(title: .Cancel)]) { [weak self] action in
            if action.title == .Yes {
                self?.logout()
            }
        }
    }
    

}

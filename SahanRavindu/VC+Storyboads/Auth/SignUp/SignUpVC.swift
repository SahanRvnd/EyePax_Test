//
//  SignInVC.swift
//  SahanRavindu
//
//  Created by Sahan Ravindu on 2021-01-31.
//

import UIKit

class SignUpVC: BaseVC {
    
    //MARK: Outlet
    @IBOutlet weak var userTxtView          : UITextField!
    @IBOutlet weak var passwordTxtView      : UITextField!
    @IBOutlet weak var confirPwTxtView      : UITextField!
    @IBOutlet weak var confirmPwView        : UIView!
    
    //MARK: Variable
    var vm = SignUpVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setDelegates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.toggleNavigationBarVisibility(.hide)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.toggleNavigationBarVisibility(.show)
    }
    
    @IBAction func didEditingConfirmPassword(_ sender: Any) {
        if confirPwTxtView.text != passwordTxtView.text {
            confirmPwView.addLayerEffects(with: .orange, borderWidth: 5.0, cornerRadius: 22)
        } else {
            confirmPwView.addLayerEffects(with: .white, borderWidth: 0.0, cornerRadius: 22)
        }
    }
    
    @IBAction func didCickSignUp(_ sender: Any) {
        didClickSignUp()
    }
    
    @IBAction func didClickLogin(_ sender: Any) {
        didClickLogin()
    }
    
    deinit {
        
    }
    
    func setupUI() {
        userTxtView.setPlaceHolder(placeholder: "Enter a user name", color: .gray)
        passwordTxtView.setPlaceHolder(placeholder: "Enter a password", color: .gray)
        confirPwTxtView.setPlaceHolder(placeholder: "Confirm password", color: .gray)
    }
    
    func setDelegates() {
        setDelegatesForTextEditors(tfs: [userTxtView, passwordTxtView, confirPwTxtView])
    }
    
    func validator()-> String {
        if (userTxtView.text == "") {
            return "Please enter a user name"
        } else if (passwordTxtView.text == "") {
            return "Please enter a password"
        } else if (confirPwTxtView.text == "") {
            return "Please enter confirm password"
        } else if (confirPwTxtView.text != passwordTxtView.text) {
            return "Confirm password is not match with the password"
        } else {
            return ""
        }
    }
    
    
    func didClickLogin() {
        ApplicationServiceProvider.shared.manageUserDirection()
    }
    
    func didClickSignUp() {
        let validator = validator()
        if validator != "" {
            AlertProvider(vc: self).showAlert(title: .Error, message: validator, action: AlertAction(title: .Ok))
        } else {
            signUp()
        }
    }
    
    func signUp() {
        self.view.endEditing(true)
        let user = User(_id: 0, uuid: "", fullName: userTxtView.text, email: "", avatarUrl: "", phone: "", accessToken: passwordTxtView.text)
        self.vm = SignUpVM(user: user)
        
        if LocalUser.current() != nil {
            // Delete Realm current user
            guard let user = LocalUser.current() else { return }
            RealmService.shared.delete(user)
        }
        
        vm.signUp() { [weak self] (status, message) in
            switch status {
            case true:
                ApplicationServiceProvider.shared.manageUserDirection()
            case false:
                guard let self = self else { return }
                AlertProvider(vc: self).showAlert(title: .Error, message: message, action: AlertAction(title: .Ok))
            }
        }
    }
    
}

// MARK: - UITextFieldDelegate
extension SignUpVC {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userTxtView {
            passwordTxtView.becomeFirstResponder()
        } else if textField == passwordTxtView {
            confirPwTxtView.becomeFirstResponder()
        } else if textField == confirPwTxtView {
            didClickSignUp()
        }
        return true
    }
    
}

//
//  SignInVC.swift
//  SahanRavindu
//
//  Created by Sahan Ravindu on 2022-05-21.
//

import UIKit

class SignInVC: BaseVC {
    
    //MARK: Outlets
    @IBOutlet weak var userTxtView      : UITextField!
    @IBOutlet weak var passwordTxtView  : UITextField!
    
    //MARK: Variable
    var vm = SignInVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setDelegates()
        self.view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.toggleNavigationBarVisibility(.hide)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.toggleNavigationBarVisibility(.show)
    }
    
    deinit {
        
    }
    
    @IBAction func didClickSignIn(_ sender: Any) {
        didClickSignIn()
    }
    
    @IBAction func didClickCreateNewAccount(_ sender: Any) {
        didClickSignUp()
    }
    
    func setupUI() {
        userTxtView.setPlaceHolder(placeholder: "Enter a user name", color: .gray)
        passwordTxtView.setPlaceHolder(placeholder: "Enter a password", color: .gray)
    }
    
    func setDelegates() {
        setDelegatesForTextEditors(tfs: [userTxtView, passwordTxtView])
    }
    
    func didClickSignIn() {
        let validator = validator()
        if validator != "" {
            AlertProvider(vc: self).showAlert(title: .Error, message: validator, action: AlertAction(title: .Ok))
        } else {
            signIn()
        }
    }
    
    func validator()-> String {
        if (userTxtView.text == "") {
            return "Please enter a user name"
        } else if (passwordTxtView.text == "") {
            return "Please enter a password"
        } else {
            return ""
        }
    }
    
    func signIn() {
        self.view.endEditing(true)
        let user = User(_id: 0, uuid: "", fullName: userTxtView.text, email: "", avatarUrl: "", phone: "", accessToken: passwordTxtView.text)
        self.vm = SignInVM(user: user)
        
        vm.signIn() { [weak self] (status, message) in
            switch status {
            case true:
                ApplicationServiceProvider.shared.manageUserDirection()
            case false:
                guard let self = self else { return }
                AlertProvider(vc: self).showAlert(title: .Error, message: message, action: AlertAction(title: .Ok))
            }
        }
    }
    
    func didClickSignUp() {
        ApplicationServiceProvider.shared.pushToViewController(in: .Auth, for: .SignUpVC, from: self)
    }
    
}

// MARK: - UITextFieldDelegate
extension SignInVC {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userTxtView {
            passwordTxtView.becomeFirstResponder()
        } else if textField == passwordTxtView {
            didClickSignIn()
        }
        return true
    }
    
}

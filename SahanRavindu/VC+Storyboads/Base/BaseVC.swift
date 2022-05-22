//
//  BaseVC.swift
//  SahanRavindu
//
//  Created by Sahan Ravindu on 2022-05-21.
//

import UIKit

class BaseVC: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    var activityView: UIActivityIndicatorView?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
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
    
    func setupTableView(with tblView: UITableView) {
        let dummyViewHeight = CGFloat(40)
        tblView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: tblView.bounds.size.width, height: dummyViewHeight))
        tblView.contentInset = UIEdgeInsets(top: -dummyViewHeight, left: 0, bottom: 0, right: 0)
        tblView.backgroundColor = .clear
    }
    
    func goBack(animation: Bool = true) {
        navigationController?.popViewController(animated: animation)
    }

}

extension BaseVC {
    func showActivityIndicator() {
        
        if #available(iOS 13.0, *) {
            activityView = UIActivityIndicatorView(style: .large)
        } else {
            // Fallback on earlier versions
        }
        activityView?.center = self.view.center
        activityView?.tag    = 102
        activityView?.color  = .red
        
        self.view.addSubview(activityView ?? UIActivityIndicatorView())
        activityView?.startAnimating()
    }
    
    func hideActivityIndicator(){
        if (activityView != nil){
            activityView?.stopAnimating()
            for view in self.view.subviews {
                if view.tag == 102 {
                    view.removeFromSuperview()
                }
            }
        }
    }
    
}

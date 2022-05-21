//
//  SignInVC.swift
//  SahanRavindu
//
//  Created by Sahan Ravindu on 2021-01-31.
//

import UIKit

class SignUpVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        getMovies()
        // Do any additional setup after loading the view.
    }
    
    
    func getMovies() {
        
        APIClient.getMovies(page: 1, completion: { (result) in
            switch result {
            case .success(let responseModel):
                print(true, responseModel.results)
            case .failure(let error):
                print(false, "Registration failed \(error.localizedDescription)")
            }
            
        })
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

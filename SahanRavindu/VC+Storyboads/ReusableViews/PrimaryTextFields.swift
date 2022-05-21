//
//  PrimaryTextFields.swift
//  SahanRavindu
//
//  Created by Sahan Ravindu on 2022-05-21.
//

import UIKit

class PrimaryTextFields: UIView {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var txtView: UITextField!
    @IBOutlet weak var imgView: UIImageView!
    
    func setUpView(cornerRadius: CGFloat?, backgroundColor: UIColor?, borderColor: UIColor?, borderWidth: CGFloat?) {
        bgView.layer.cornerRadius = cornerRadius ?? 0
        bgView.backgroundColor = backgroundColor
        bgView.addLayerEffects(with: borderColor, borderWidth: borderWidth ?? 0, cornerRadius: cornerRadius ?? 0)
    }
    
    func setUpText(placeholder: String?, font: UIFont?, textColor: UIColor?) {
        txtView.placeholder = placeholder ?? ""
        txtView.font = font ?? UIFont()
        txtView.textColor = textColor ?? UIColor.black
    }
    

}

//
//  Extenstions.swift
//  SahanRavindu
//
//  Created by Sahan Ravindu on 2022-05-21.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage

extension UIImageView {
    func setImageWithUrl(_ urlString: String, placeholderImage: UIImage = UIImage()) {
        if let url = URL(string: urlString) {
            self.af.setImage(withURL: url, placeholderImage: placeholderImage)
        }
    }
}

extension UIViewController {
    internal enum NavigationBarVisibility {
        case show
        case hide
    }
    
    func toggleNavigationBarVisibility(_ visibility: NavigationBarVisibility) {
        switch visibility {
        case .show:
            navigationController?.navigationBar.isHidden = false
        case .hide:
            navigationController?.navigationBar.isHidden = true
        }
    }
}

extension UIView {
    func addLayerEffects(with borderColor: UIColor? = nil, borderWidth: CGFloat = 0.0, cornerRadius: CGFloat = 0.0) {
        self.layer.borderColor = borderColor?.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func addShadow(offSet: CGFloat = 0.0, color: UIColor = .lightGray, opacity: CGFloat = 1.0, radius: CGFloat = 5.0) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = CGSize(width: offSet, height: offSet)
        self.layer.shadowOpacity = Float(opacity)
        self.layer.shouldRasterize = false
        self.layer.masksToBounds = false
        self.layer.shadowRadius = radius
    }
    
    func convertToImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.isOpaque, 0.0)
        self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        let snapshotImageFromMyView = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return snapshotImageFromMyView!
    }
    
    func applyGradient(isTopBottom: Bool, colorArray: [UIColor]) {
        if let sublayers = layer.sublayers {
            let _ = sublayers.filter({ $0 is CAGradientLayer }).map({ $0.removeFromSuperlayer() })
        }
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colorArray.map({ $0.cgColor })
        if isTopBottom {
            gradientLayer.locations = [0.0, 1.0]
        } else {
            //leftRight
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        }
        
        backgroundColor = .clear
        gradientLayer.frame = self.bounds
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func didTapAnimation() {
        UIView.animate(withDuration: 0.3,
                       animations: {
                        self.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
                       },
                       completion: { _ in
                        UIView.animate(withDuration: 0.3) {
                            self.transform = CGAffineTransform.identity
                        }
                       })
    }
    
    func aspectRation(_ ratio: CGFloat) -> NSLayoutConstraint {
        
        return NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: self, attribute: .width, multiplier: ratio, constant: 0)
    }
    
    
}

extension UITextField {
    func setPlaceHolder(placeholder: String, color: UIColor) {
        self.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: color]
        )
    }
}

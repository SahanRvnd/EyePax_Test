//
//  TabBarVC.swift
//  SahanRavindu
//
//  Created by Sahan Ravindu on 2022-05-21.
//

import UIKit

class TabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layer = CAShapeLayer()
        layer.path = UIBezierPath(roundedRect: CGRect(x: self.tabBar.bounds.width/11, y: self.tabBar.bounds.minY - 10, width: self.tabBar.bounds.width - (self.tabBar.bounds.width/11 * 2), height: self.tabBar.bounds.height + 5), cornerRadius: (self.tabBar.frame.width/2)).cgPath
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        layer.shadowRadius = 25.0
        layer.shadowOpacity = 0.3
        layer.borderWidth = 1.0
        layer.opacity = 1.0
        layer.isHidden = false
        layer.masksToBounds = false
        layer.fillColor = UIColor.white.cgColor
        
        self.tabBar.layer.insertSublayer(layer, at: 0)
        
        if let items = self.tabBar.items {
            items.forEach {
                item in
                item.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
               
                
            }
        }

        self.tabBar.itemWidth = 44
        UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -6)
        // Do any additional setup after loading the view.
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

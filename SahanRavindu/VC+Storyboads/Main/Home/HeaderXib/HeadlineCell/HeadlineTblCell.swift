//
//  HeadlineTblCell.swift
//  SahanRavindu
//
//  Created by Sahan Ravindu on 2022-05-22.
//

import UIKit

class HeadlineTblCell: UITableViewCell {
    
    //MARK: Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: Variables
    let sectionInsets         = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 10.0)
    let itemsPerRow           : CGFloat = 2
    lazy var articleList            : [Article] = [] {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                self.collectionView.reloadData()
            }
        }
    }
    var cellTap                     : ((Article)->())?
    let headlineClCellIdentifire    = "HeadlineClCell"
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        collectionView.reloadData()
    }
    
    deinit {}
    
    func setupUI() {
        collectionView.delegate   = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: headlineClCellIdentifire, bundle: .main), forCellWithReuseIdentifier: headlineClCellIdentifire)
    }
    
    func cellConfiguration(with model: [Article]) {
        self.articleList = model
        self.collectionView.reloadData()
        self.layoutIfNeeded()
    }
}

//MARK:Collection View Delegate
extension HeadlineTblCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        switch collectionView {
        case collectionView:
            return 1
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case collectionView:
            return articleList.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case collectionView:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.headlineClCellIdentifire, for: indexPath) as? HeadlineClCell {
                
                if articleList.count >= indexPath.row {
                    cell.cellconfiguration(with: articleList[indexPath.row])
                }
                
                return cell
            }
            
            return UICollectionViewCell()
            
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if articleList.count >= indexPath.row {
            let item = articleList[indexPath.row]
            cellTap?(item)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView {
        case collectionView:
            let paddingSpace = sectionInsets.left * (itemsPerRow*2)
            let availableWidth = collectionView.frame.width - paddingSpace
            let widthPerItem = availableWidth/8 * 7
            let heightPerItem = collectionView.frame.height-20
            return CGSize(width: widthPerItem, height: heightPerItem)
        default:
            return CGSize(width: 0.0, height: 0.0)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        switch collectionView {
        case collectionView:
            return sectionInsets
        default:
            return UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        }
        
    }
    
}

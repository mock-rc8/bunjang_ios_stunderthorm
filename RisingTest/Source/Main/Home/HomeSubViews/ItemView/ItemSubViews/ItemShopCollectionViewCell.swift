//
//  ItemShopCollectionViewCell.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/26.
//

import UIKit

class ItemShopCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var heartBtn: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var safePayView: UIImageView!
    static let identifier = "ItemShopCollectionViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
}




//MARK: -- 높이 설정
//CGFloat height = myCollectionView.collectionViewLayout.collectionViewContentSize.height
//heightConstraint.constant = height
//self.view.setNeedsLayout() Or self.view.layoutIfNeeded()

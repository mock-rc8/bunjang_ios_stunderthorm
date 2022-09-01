//
//  AdShopCollectionViewCell.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/26.
//

import UIKit

class AdShopCollectionViewCell: UICollectionViewCell {
static let identifier = "AdShopCollectionViewCell"
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var safePayView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var titleImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

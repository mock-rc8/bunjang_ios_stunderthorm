//
//  BrandSuggestCell.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/30.
//

import UIKit

class BrandSuggestCell: UICollectionViewCell {
    @IBOutlet weak var titleImgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var safePayView: UIImageView!
    @IBOutlet weak var AD_View: UILabel!
    @IBOutlet weak var heartBtn: UIButton!
    static let identifier = "BrandSuggestCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func heartBtnAction(_ sender: UIButton) {
    }
}

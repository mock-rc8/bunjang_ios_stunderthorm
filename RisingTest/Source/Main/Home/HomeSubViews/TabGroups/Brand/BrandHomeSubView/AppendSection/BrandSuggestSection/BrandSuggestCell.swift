//
//  BrandSuggestCell.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/30.
//

import UIKit

class BrandSuggestCell: UICollectionViewCell {
    static let identifier = "BrandSuggestCell"
    @IBOutlet weak var titleImgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var safePayView: UIImageView!
    @IBOutlet weak var AD_View: UILabel!
    @IBOutlet weak var heartBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func heartBtnAction(_ sender: UIButton) {
    }
    func setData(_ data: CategoryResult){
        self.titleLabel.text = data.postTitle
        self.priceLabel.text = "\(data.price)원"
        self.safePayView.isHidden = !data.payStatus
    }
}

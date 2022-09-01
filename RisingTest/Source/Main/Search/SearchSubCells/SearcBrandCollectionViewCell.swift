//
//  SearcBrandCollectionViewCell.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/29.
//

import UIKit

class SearcBrandCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var mainImgView: UIImageView!
    @IBOutlet weak var brandKorLabel: UILabel!
    @IBOutlet weak var brandEngLabel: UILabel!
    @IBOutlet weak var likesCountLabel: UILabel!
    static let identifier = "SearcBrandCollectionViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setData(_ data: BrandEntireResult){
        self.brandKorLabel.text = data.brandName
        self.brandEngLabel.text = data.brandEngName
        self.likesCountLabel.text = String(data.postNum)
    }
}

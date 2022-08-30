//
//  BrandSuggestHeader.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/30.
//

import UIKit

class BrandFollowHeader: UICollectionReusableView {
    @IBOutlet weak var brandImgView: UIImageView!
    @IBOutlet weak var brandTitleLabel: UILabel!
    @IBOutlet weak var brandSubTitleLabel: UILabel!
    @IBOutlet weak var followBtn: UIButton!
    @IBOutlet weak var likesCountLabel: UILabel!
    static let identifier = "BrandFollowHeader"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func followBtnAction(_ sender: Any) {
    }
    
}

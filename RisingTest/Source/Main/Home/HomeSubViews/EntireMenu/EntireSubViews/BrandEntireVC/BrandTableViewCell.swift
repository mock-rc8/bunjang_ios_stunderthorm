//
//  BrandTableViewCell.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/26.
//

import UIKit

class BrandTableViewCell: UITableViewCell {
static let identifier = "BrandTableViewCell"
    @IBOutlet weak var brandKorLabel: UILabel!
    @IBOutlet weak var followBtn: UIButton!
    @IBOutlet weak var brandImgView: UIImageView!
    @IBOutlet weak var brandEngLabel: UILabel!
    @IBOutlet weak var likesCountLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setData(_ data: BrandEntireResult){
        self.brandKorLabel.text = data.brandName
        self.brandEngLabel.text = data.brandEngName
        self.likesCountLabel.text = String(data.postNum)
    }
}

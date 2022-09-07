//
//  ZzimCell.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/09/05.
//

import UIKit

class ZzimCell: UICollectionViewCell {
    @IBOutlet weak var haert: UIButton!
    @IBOutlet weak var itemImg: UIImageView!
    @IBOutlet weak var safePay: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var uploadDate: UILabel!
    @IBOutlet weak var shopName: UILabel!
    static let identifier = "ZzimCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func heartBtn(_ sender: UIButton) {
    }
}

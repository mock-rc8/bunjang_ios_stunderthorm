//
//  RecentCell.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/09/05.
//

import UIKit

class RecentCell: UICollectionViewCell {
    @IBOutlet weak var itemImg: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var safePay: UIImageView!
    static let identifier = "RecentCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

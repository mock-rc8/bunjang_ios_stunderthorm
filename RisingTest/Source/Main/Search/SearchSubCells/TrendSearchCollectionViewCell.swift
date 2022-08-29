//
//  TrendSearchCollectionViewCell.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/29.
//

import UIKit

class TrendSearchCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var bellBtn: UIButton!
    static let identifier = "TrendSearchCollectionViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bellBtn.layer.cornerRadius = bellBtn.layer.frame.height / 2
    }

}

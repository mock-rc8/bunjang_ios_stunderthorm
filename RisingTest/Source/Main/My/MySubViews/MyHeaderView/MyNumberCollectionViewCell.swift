//
//  MyNumberCollectionViewCell.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/29.
//

import UIKit

class MyNumberCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var numberInfoLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    static let identifier = "MyNumberCollectionViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

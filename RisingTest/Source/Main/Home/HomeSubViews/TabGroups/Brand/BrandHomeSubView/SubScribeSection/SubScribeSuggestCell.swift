//
//  SubScribeSuggestCell.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/30.
//

import UIKit

class SubScribeSuggestCell: UICollectionViewCell {
    @IBOutlet weak var titleImg: UIImageView!
    @IBOutlet weak var safePayImg: UIImageView!
    @IBOutlet weak var heartBtn: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var loactionLabel: UILabel!
    @IBOutlet weak var uploadDateLabel: UILabel!
    static let identifier = "SubScribeSuggestCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func heartBtnAction(_ sender: UIButton) {
    }
}

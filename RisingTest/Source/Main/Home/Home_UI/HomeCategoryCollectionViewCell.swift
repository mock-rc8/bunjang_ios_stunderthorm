//
//  HomeCategoryCollectionViewCell.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/24.
//

import UIKit

class HomeCategoryCollectionViewCell: UICollectionViewCell {
static let identifier = "HomeCategoryCollectionViewCell"
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

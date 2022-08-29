//
//  MyInfoCollectionViewCell.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/29.
//

import UIKit

class MyInfoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var infoImage: UIImageView!
    static let identifier = "MyInfoCollectionViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

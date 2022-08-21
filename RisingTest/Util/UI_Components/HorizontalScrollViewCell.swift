//
//  StoreSliderCollectionViewCell.swift
//  NavigationBarDemo
//
//  Created by 김태윤 on 2022/08/19.
//

import UIKit

class HorizontalScrollViewCell: UICollectionViewCell {
    @IBOutlet weak var SliderTitleLabel: UILabel!
    @IBOutlet weak var SliderImgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        print("StoreSliderCollectionViewCell")
    }

}

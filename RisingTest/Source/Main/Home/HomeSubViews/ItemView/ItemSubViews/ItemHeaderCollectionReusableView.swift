//
//  ItemHeaderCollectionReusableView.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/26.
//

import UIKit

class ItemHeaderCollectionReusableView: UICollectionReusableView {
    @IBOutlet weak var headerLabel: UILabel!
    static let identifier = "ItemHeaderCollectionReusableView"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}

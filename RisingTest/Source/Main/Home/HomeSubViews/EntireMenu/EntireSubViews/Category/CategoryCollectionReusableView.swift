//
//  CategoryCollectionReusableView.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/25.
//

import UIKit

class CategoryCollectionReusableView: UICollectionReusableView {
    @IBOutlet weak var headerLabel: UILabel!
    static let identifier = "CategoryCollectionReusableView"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}

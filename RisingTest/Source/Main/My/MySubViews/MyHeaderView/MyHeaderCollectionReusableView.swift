//
//  MyHeaderCollectionReusableView.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/29.
//

import UIKit

class MyHeaderCollectionReusableView: UICollectionReusableView {
    @IBOutlet weak var numberCollection: UICollectionView!
    @IBOutlet weak var shopInfoCollection: UICollectionView!
    @IBOutlet weak var headerWrapper: UIStackView!
    var myIdx = 0
    
    static let identifier = "MyHeaderCollectionReusableView"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}

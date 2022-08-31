//
//  CateMainCollectionReusableView.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/29.
//

import UIKit

class CateMainCollectionReusableView: UICollectionReusableView {
    @IBOutlet weak var headerViewTop: NSLayoutConstraint!
    public private(set) var myHeaderWrapperHeight : CGFloat = 0.0
    public private(set) var myHeaderHeight: CGFloat = 0.0
    @IBOutlet weak var headerWrapper: UIStackView!
    @IBOutlet weak var scrollCollectionView: UICollectionView!
    @IBOutlet weak var categoryImg: UIImageView!
    @IBOutlet weak var categoryTitle: UILabel!
    static let identifier = "CateMainCollectionReusableView"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        myHeaderWrapperHeight = headerWrapper.frame.height
        myHeaderHeight = self.frame.height
    }
}

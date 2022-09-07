//
//  SearchReHeaderView.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/09/02.
//

import UIKit

class SearchReHeaderView: UICollectionReusableView {
    @IBOutlet weak var filterBtn: UIButton!
    @IBOutlet weak var headerViewTop: NSLayoutConstraint!
    public private(set) var myHeaderWrapperHeight : CGFloat = 0.0
    @IBOutlet weak var scrollCollectionView: UICollectionView!
    public private(set) var myHeaderHeight: CGFloat = 0.0
    static let identifier = "SearchReHeaderView"
    @IBOutlet weak var headerWrapper: UIView!
    lazy var scrollManager = CateFilterManager()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        scrollCollectionView.delegate = scrollManager
        scrollCollectionView.dataSource = scrollManager
        scrollCollectionView.collectionViewLayout = scrollManager.createCompositionalLayout()
        scrollCollectionView.register(UINib(nibName: RecentSearchCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: RecentSearchCollectionViewCell.identifier)
        filterBtn.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        filterBtn.titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        filterBtn.imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)

    }
    
}

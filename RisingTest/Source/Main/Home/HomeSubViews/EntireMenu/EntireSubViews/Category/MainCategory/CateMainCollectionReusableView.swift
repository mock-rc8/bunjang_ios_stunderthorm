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
    @IBOutlet weak var innerWrapper: UIView!
    lazy var scrollManager = CateFilterManager()
    static let identifier = "CateMainCollectionReusableView"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        myHeaderWrapperHeight = headerWrapper.frame.height
        myHeaderHeight = self.frame.height
        scrollCollectionView.delegate = scrollManager
        scrollCollectionView.dataSource = scrollManager
        scrollCollectionView.collectionViewLayout = scrollManager.createCompositionalLayout()
        scrollCollectionView.register(UINib(nibName: RecentSearchCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: RecentSearchCollectionViewCell.identifier)
    }
}

class CateFilterManager:NSObject,UICollectionViewDataSource,UICollectionViewDelegate{
    var data : [String] = ["브랜드","동네","가격","판매완료","혜택","검수","상점"]
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return data.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentSearchCollectionViewCell.identifier, for: indexPath) as! RecentSearchCollectionViewCell
        cell.btn.isHidden = true
        cell.myTitleLabel.text = data[indexPath.item]
        cell.myTitleLabel.font = .systemFont(ofSize: 14, weight: .bold)
        cell.myTitleLabel.topInset = 10
        cell.myTitleLabel.leftInset = 10
        cell.myTitleLabel.rightInset = 10
        cell.myTitleLabel.bottomInset = 10
        cell.myTitleLabel.textColor = .gray
        cell.setCornerRadius(5)
            return cell
    }
    func createCompositionalLayout() -> UICollectionViewLayout{
        let layout = UICollectionViewCompositionalLayout{
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            // 아이템에 대한 사이즈 - absolute는 고정값, estimated는 추측, fraction 퍼센트
            let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(100), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            // 아이템 간의 간격 설정
            item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 10)
            // 그룹 사이즈
            let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(100), heightDimension: itemSize.heightDimension)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            // 그룹으로 섹션 만들기
            let section = NSCollectionLayoutSection(group: group)
            // 스크롤 뷰 간격
            section.interGroupSpacing = 10
            // 섹션에 대한 간격 설정
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0)
            section.orthogonalScrollingBehavior = .continuous
            //섹션 헤더와 관련된 설정
            return section
        }
        return layout
    }
}

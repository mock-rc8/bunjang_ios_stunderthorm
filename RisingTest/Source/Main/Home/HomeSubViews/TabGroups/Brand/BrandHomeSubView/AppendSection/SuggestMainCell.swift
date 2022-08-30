//
//  SuggestMainCell.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/30.
//

import UIKit

class SuggestMainCell: UICollectionViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    static let identifier = "SuggestMainCell"
    lazy var suggestMainCollectionManager = SuggestMainCollectionManager()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setCollectionView(_ width: CGFloat){
        self.collectionView.delegate = suggestMainCollectionManager
        self.collectionView.dataSource = suggestMainCollectionManager
        self.collectionView.collectionViewLayout = suggestMainCollectionManager.createSliderCompositionalLayout(width)
        self.collectionView.register(UINib(nibName: BrandFollowHeader.identifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: BrandFollowHeader.identifier)
        self.collectionView.register(UINib(nibName: BrandSuggestCell.identifier, bundle: nil), forCellWithReuseIdentifier: BrandSuggestCell.identifier)
        self.collectionView.isScrollEnabled = false
    }
}

class SuggestMainCollectionManager:NSObject,UICollectionViewDataSource,UICollectionViewDelegate{
    var scrollData: [ScrollData] = [ScrollData(type: .append, title: "추가"),ScrollData(type: .append, title: "추가"),ScrollData(type: .edit, title: "편집")]
    var isClicked: [Bool]
    var myVC: UIViewController?
    var myCollection: UICollectionView?
    override init() {
        self.isClicked = self.scrollData.map{_ in false}
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return scrollData.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BrandSuggestCell.identifier, for: indexPath) as! BrandSuggestCell
        let idx = indexPath.item
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind{
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: BrandFollowHeader.identifier, for: indexPath) as! BrandFollowHeader
            return header
        default:
            return UICollectionReusableView()
        }
    }
    func createSliderCompositionalLayout(_ width: CGFloat) -> UICollectionViewLayout{
        //컴포지셔널 레이아웃 생성
        let layout = UICollectionViewCompositionalLayout{
            (sectionIndex: Int,layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            //아이템 사이즈 설정
            let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(width/2.5), heightDimension: .estimated(width/2))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
            let groupSize = NSCollectionLayoutSize(widthDimension: itemSize.widthDimension, heightDimension: itemSize.heightDimension)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            // 수평 스크롤 섹션 만들기
            section.orthogonalScrollingBehavior = .continuous
            //섹션 헤더 사이즈 설정
            let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerFooterSize,
                elementKind: UICollectionView.elementKindSectionHeader,alignment: .top)
            sectionHeader.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0)
            section.boundarySupplementaryItems = [sectionHeader]
            return section
        }
        return layout
    }
}

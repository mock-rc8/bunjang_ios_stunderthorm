//
//  AdShopManager.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/26.
//

import UIKit
import Foundation
class AdShopManager:NSObject,UICollectionViewDataSource,UICollectionViewDelegate{
    var data : [AdShopSection]
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return data.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(data[section].count)
        return data[section].count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch data[indexPath.section] {
        case .similar(let items):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemShopCollectionViewCell.identifier, for: indexPath) as! ItemShopCollectionViewCell
            return cell
        case .ad(let items):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AdShopCollectionViewCell.identifier, for: indexPath) as! AdShopCollectionViewCell
            return cell
        }
    }
    init(data: [AdShopSection]){
        self.data = data
    }
    static public func createCompositionalLayout() -> UICollectionViewLayout{
        let layout = UICollectionViewCompositionalLayout{
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            // 아이템에 대한 사이즈 - absolute는 고정값, estimated는 추측, fraction 퍼센트
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .estimated(250))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            // 아이템 간의 간격 설정
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
            // 그룹 사이즈
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: itemSize.heightDimension)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item,item,item])
            // 그룹으로 섹션 만들기
            let section = NSCollectionLayoutSection(group: group)
            // 섹션에 대한 간격 설정
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            //섹션 헤더와 관련된 설정
            let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(30))
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerFooterSize,
                elementKind: "header",alignment: .top)
            section.boundarySupplementaryItems = [sectionHeader]
            return section
        }
        return layout
    }
    func setData(data:[AdShopSection]){
        self.data = data
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ItemHeaderCollectionReusableView.identifier, for: indexPath) as? ItemHeaderCollectionReusableView else {
            return UICollectionReusableView()
        }
        headerView.headerLabel.text = data[indexPath.section].title
        headerView.headerLabel.font = .systemFont(ofSize: 18, weight: .bold)
        return headerView
    }
}

enum AdShopSection{
    case similar([String])
    case ad([String])
    var items: [String]{
        switch self{
        case .similar(let items), .ad(let items):
            return items
        }
    }
    var count : Int{
        return items.count
    }
    var title: String{
        switch self{
        case .similar:
            return "이 상품과 비슷해요"
        case .ad:
            return "파워쇼핑 AD"
        }
    }
}
struct AdShopData{
    static let shared = AdShopData()
    private let similar : AdShopSection = {
        .similar(["hello","hello","hello","hello","hello","hello","hello","hello"])
    }()
    private let ad : AdShopSection = {
        .ad(["hello","hello","hello","hello","hello","hello"])
    }()
    var adData : [AdShopSection] {
        [similar,ad]
    }
}

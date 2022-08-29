//
//  MyInfoManager.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/29.
//

import Foundation
import UIKit
class MyInfoManager:NSObject,UICollectionViewDataSource,UICollectionViewDelegate{
    var infoData: [MyInfoType] = MyInfoType.allCases
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.infoData.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyInfoCollectionViewCell.identifier, for: indexPath) as! MyInfoCollectionViewCell
        let idx = indexPath.item
        cell.infoLabel.text = self.infoData[idx].rawValue
        cell.infoImage.image = UIImage(named: String(describing: self.infoData[idx].self))
        return cell
    }
    func createSliderCompositionalLayout(_ height: CGFloat) -> UICollectionViewLayout{
        //컴포지셔널 레이아웃 생성
        let layout = UICollectionViewCompositionalLayout{
            (sectionIndex: Int,layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            //아이템 사이즈 설정
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalWidth(0.20))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: itemSize.heightDimension)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            // 수평 스크롤 섹션 만들기
            return section
        }
        return layout
    }
}
enum MyInfoType:String,CaseIterable{
    case center = "판매자센터"
    case history = "거래 내역"
    case delivery = "택배관리"
    case customer = "고객센터"
}

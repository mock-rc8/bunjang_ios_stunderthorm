//
//  MyNumberManager.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/29.
//

import Foundation
import UIKit
class MyNumberManager:NSObject,UICollectionViewDataSource,UICollectionViewDelegate{
    var numberData: [MyNumberType] = MyNumberType.allCases
    var dataNumber: [Int] = [1,0,0,0]

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.numberData.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyNumberCollectionViewCell.identifier, for: indexPath) as! MyNumberCollectionViewCell
        let idx = indexPath.item
        cell.numberLabel.text = String(dataNumber[idx])
        cell.numberInfoLabel.text = numberData[idx].rawValue
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
enum MyNumberType:String,CaseIterable{
    case heart = "찜"
    case after = "후기"
    case follower = "팔로워"
    case following = "팔로잉"
}

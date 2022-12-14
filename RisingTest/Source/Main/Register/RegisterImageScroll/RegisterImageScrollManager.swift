//
//  RegisterImageScrollManager.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/25.
//

import Foundation
import UIKit
import Photos
class RegisterImageScrollManager:NSObject,UICollectionViewDataSource,UICollectionViewDelegate{
    var data:[String]
    var tempData: [Int] = [1,1]
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tempData[section]
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item{
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RegiCollectionViewCell.identifier, for: indexPath) as! RegiCollectionViewCell
            cell.contentView.isUserInteractionEnabled = true
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RegisterImageScrollCollectionViewCell.identifier, for: indexPath) as! RegisterImageScrollCollectionViewCell
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("is selected")
    }
    init(data:[String]){
        self.data = data
    }
    static public func createSliderCompositionalLayout(_ height: CGFloat) -> UICollectionViewLayout{
        //컴포지셔널 레이아웃 생성
        let layout = UICollectionViewCompositionalLayout{
            (sectionIndex: Int,layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            //아이템 사이즈 설정
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalHeight(1), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            //아이템 간의 간격 설정
            item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
            // 그룹 사이즈 - 높이가 아이템의 크기와 같음 => 1줄이다.
            let groupSize = NSCollectionLayoutSize(widthDimension: itemSize.widthDimension, heightDimension: .absolute(height))
            //그룹 사이즈로 그룹 만들기
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            // 그룹으로 섹션 만들기
            let section = NSCollectionLayoutSection(group: group)
            // 수평 스크롤 섹션 만들기
            section.orthogonalScrollingBehavior = .continuous
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
            return section
        }
        return layout
    }
    func setData(data:[String]){
        self.data = data
    }
}

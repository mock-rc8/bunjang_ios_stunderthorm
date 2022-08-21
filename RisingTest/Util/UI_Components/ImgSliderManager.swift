//
//  SliderCollection.swift
//  NavigationBarDemo
//
//  Created by 김태윤 on 2022/08/16.
//

import UIKit

class ImgSliderManager:NSObject,UICollectionViewDataSource,UICollectionViewDelegate{
    var data:[String]
    var controllerProtocol:SliderDelegate!
    private var willIdx: Int = 0
    private var didIdx: Int = 0
    public private(set) var nowIdx: Int = 0
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImgSliderCollectionViewCell", for: indexPath) as! ImgSliderCollectionViewCell
        cell.tempLabel.text = data[indexPath.item]
        return cell
    }
    init(data:[String],updater:SliderDelegate){
        self.data = data
        self.controllerProtocol = updater
    }
    static public func createSliderCompositionalLayout() -> UICollectionViewLayout{
        //컴포지셔널 레이아웃 생성
        let layout = UICollectionViewCompositionalLayout{
            (sectionIndex: Int,layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            //아이템 사이즈 설정
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            //아이템 간의 간격 설정
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            // 그룹 사이즈 - 높이가 아이템의 크기와 같음 => 1줄이다.
            let groupSize = NSCollectionLayoutSize(widthDimension: itemSize.widthDimension, heightDimension: itemSize.heightDimension)
            //그룹 사이즈로 그룹 만들기
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            // 그룹으로 섹션 만들기
            let section = NSCollectionLayoutSection(group: group)
            // 수평 스크롤 섹션 만들기
            section.orthogonalScrollingBehavior = .groupPagingCentered
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            return section
        }
        return layout
    }
    // 스크롤 확인 용
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.willIdx = indexPath.item
    }
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.didIdx = indexPath.item
        self.isChanged()
    }
    func isChanged(){
        if(self.didIdx != self.willIdx){
            self.controllerProtocol.currentPage(index: self.willIdx)
        }
    }
    func setData(data:[String]){
        self.data = data
    }
}

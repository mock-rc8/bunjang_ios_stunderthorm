//
//  HomeCategoryUIView.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/24.
//

import UIKit

class HomeCategoryUIView: UIView{
    var data: [String] = ["찜","키덜트","스니커즈","내폰시세","자전거","스타굿즈","시계","뷰티/미용","디지털/가전","커뮤니티"]
    var horizontalScrollViewManager: HomeCategoryManager?
    var sliderCollection: UICollectionView!
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        horizontalScrollViewManager = HomeCategoryManager(data: self.data)
        self.sliderCollection = UICollectionView(frame: .zero, collectionViewLayout: HomeCategoryManager.createSliderCompositionalLayout(self.frame.height))
        self.sliderCollection.register(UINib(nibName: HomeCategoryCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: HomeCategoryCollectionViewCell.identifier)
        self.sliderCollection.dataSource = horizontalScrollViewManager
        self.sliderCollection.delegate = horizontalScrollViewManager
        self.sliderCollection.alwaysBounceVertical = false
        //self.sliderCollection.isScrollEnabled = false
        self.sliderCollection.collectionViewLayout = HomeCategoryManager.createSliderCompositionalLayout(self.frame.height)
        self.sliderCollection.isScrollEnabled = false
        self.layout()
    }
    private func layout(){
        self.sliderCollection.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(sliderCollection)
        NSLayoutConstraint.activate([
            self.sliderCollection.topAnchor.constraint(equalTo: self.topAnchor),
            self.sliderCollection.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.sliderCollection.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.sliderCollection.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    func setData(data:[String]){
        self.data = data
        horizontalScrollViewManager?.setData(data:data)
    }
}




class HomeCategoryManager:NSObject,UICollectionViewDataSource,UICollectionViewDelegate{
    var data:[String]
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCategoryCollectionViewCell.identifier, for: indexPath) as! HomeCategoryCollectionViewCell
        let idx = indexPath.item
        cell.categoryLabel.text = data[idx]
        cell.imageView.image = UIImage(named: data[idx].replacingOccurrences(of: "/", with: ":"))
        return cell
    }
    init(data:[String]){
        self.data = data
    }
    static public func createSliderCompositionalLayout(_ height: CGFloat) -> UICollectionViewLayout{
        //컴포지셔널 레이아웃 생성
        let layout = UICollectionViewCompositionalLayout{
            (sectionIndex: Int,layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            //아이템 사이즈 설정
            let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(height / 2 + 20), heightDimension: .absolute(height / 2))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            //아이템 간의 간격 설정
            item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
            // 그룹 사이즈 - 높이가 아이템의 크기와 같음 => 1줄이다.
            let groupSize = NSCollectionLayoutSize(widthDimension: itemSize.widthDimension, heightDimension: .absolute(height))
            //그룹 사이즈로 그룹 만들기
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item,item])
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

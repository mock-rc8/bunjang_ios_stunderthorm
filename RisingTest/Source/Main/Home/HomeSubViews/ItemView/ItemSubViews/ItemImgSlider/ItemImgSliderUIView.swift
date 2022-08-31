//
//  ItemBannerUIView.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/31.
//

import Foundation
import UIKit
import Kingfisher
class ItemImgSlider: UIView,SliderDelegate{
    lazy var itemImgSliderManager = ItemImgSliderManager(updater: self)
    var sliderCollection: UICollectionView!
    let sliderPageControl: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(white: 1, alpha: 0.5)
        label.text = ""
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .white
        return label
    }()
    var data: [String] = []
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        //itemImgSliderManager = ItemImgSliderManager(data: [], updater: self)
        self.sliderCollection = UICollectionView(frame: .zero, collectionViewLayout: HomeImgSliderManager.createSliderCompositionalLayout(self.frame.height))
        self.sliderCollection.register(UINib(nibName: HomeImgCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: HomeImgCollectionViewCell.identifier)
        self.sliderCollection.dataSource = itemImgSliderManager
        self.sliderCollection.delegate = itemImgSliderManager
        self.sliderCollection.alwaysBounceVertical = false
        self.sliderCollection.isScrollEnabled = false
        self.sliderCollection.collectionViewLayout = itemImgSliderManager.createSliderCompositionalLayout(self.frame.height)
        self.pageControlStyle()
        self.layout()
    }
    private func layout(){
        self.sliderPageControl.translatesAutoresizingMaskIntoConstraints = false
        self.sliderCollection.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(sliderCollection)
        self.addSubview(sliderPageControl)
        NSLayoutConstraint.activate([
            self.sliderCollection.topAnchor.constraint(equalTo: self.topAnchor,constant: 0),
            self.sliderCollection.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.sliderCollection.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.sliderCollection.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.sliderPageControl.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -20),
            self.sliderPageControl.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -20),
            self.sliderPageControl.heightAnchor.constraint(equalToConstant: 35),
            self.sliderPageControl.widthAnchor.constraint(equalTo: self.sliderPageControl.heightAnchor, multiplier: 1.4 )
        ])
    }
    func pageControlStyle(){
        //Page Controller
        print(self.data.count)
        if self.data.count < 2 {
            self.sliderPageControl.isHidden = true
        }else{
            self.sliderPageControl.isHidden = false
            self.sliderPageControl.text = "\(1) / \(self.data.count)"
        }
    }
    func setData(data:[String]){
        print("setDataCalled!!")
        self.data = data
        self.itemImgSliderManager.setData(data: data)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            self.sliderCollection.reloadData()
        }
        self.pageControlStyle()
    }
    func numberOfPages(count: Int){
//        self.sliderPageControl.numberOfPages = count
    }
    func currentPage(index: Int){
//        self.sliderPageControl.currentPage = index
        print("Sliding!!","\(index+1) / \(self.data.count)")
        self.sliderPageControl.text = "\(index+1) / \(self.data.count)"
            
    }
}
class ItemImgSliderManager:NSObject,UICollectionViewDataSource,UICollectionViewDelegate{
    var data:[UIImageView] = []
    var controllerProtocol:SliderDelegate!
    private var willIdx: Int = 0
    private var didIdx: Int = 0
    public private(set) var nowIdx: Int = 0
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeImgCollectionViewCell.identifier, for: indexPath) as! HomeImgCollectionViewCell
        cell.imgaeView.image =  data[indexPath.item].image
        return cell
    }
    init(updater:SliderDelegate){
        self.controllerProtocol = updater
    }
    func createSliderCompositionalLayout(_ itemHeight: CGFloat) -> UICollectionViewLayout{
        print(itemHeight)
        //컴포지셔널 레이아웃 생성
        let layout = UICollectionViewCompositionalLayout{
            (sectionIndex: Int,layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            //아이템 사이즈 설정
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),heightDimension: .absolute(itemHeight))
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
    //MARK: -- 스크롤 확인 용
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
        self.data = data.map{ (str:String) -> UIImageView in
            let imageView = UIImageView()
            imageView.kf.setImage(with: URL(string: str))
            return imageView
        }
    }
}

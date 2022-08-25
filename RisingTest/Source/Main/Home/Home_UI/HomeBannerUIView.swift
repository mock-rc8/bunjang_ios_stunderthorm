//
//  HomeBannerUIView.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/24.
//

import Foundation
import UIKit
class HomeImgSlider: UIView,SliderDelegate{
    var data: [String] = ["banner1","banner2"]
    var homeImgSliderManager : HomeImgSliderManager?
    var sliderCollection: UICollectionView!
    var sliderPageControl: UIView!
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        homeImgSliderManager = HomeImgSliderManager(data: self.data, updater: self)
        self.sliderCollection = UICollectionView(frame: .zero, collectionViewLayout: HomeImgSliderManager.createSliderCompositionalLayout(self.frame.height))
        self.sliderCollection.register(UINib(nibName: HomeImgCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: HomeImgCollectionViewCell.identifier)
        self.sliderCollection.dataSource = homeImgSliderManager
        self.sliderCollection.delegate = homeImgSliderManager
        self.sliderCollection.alwaysBounceVertical = false
        self.sliderCollection.isScrollEnabled = false
        self.sliderCollection.collectionViewLayout = HomeImgSliderManager.createSliderCompositionalLayout(self.frame.height)
        //Page Controller
        self.sliderPageControl = {
            let view = UIView()
            view.backgroundColor = .blue
            return view
        }()
//        self.sliderPageControl.pageIndicatorTintColor = .systemGray5
//        self.sliderPageControl.currentPageIndicatorTintColor = UIColor.orange
//        self.sliderPageControl.numberOfPages = (self.homeImgSliderManager?.data.count)!
//        self.sliderPageControl.currentPage = self.homeImgSliderManager!.nowIdx
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
            self.sliderPageControl.widthAnchor.constraint(equalToConstant: 50),
            self.sliderPageControl.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    func setData(data:[String]){
        self.data = data
        self.homeImgSliderManager?.setData(data: self.data)
    }
    func numberOfPages(count: Int){
//        self.sliderPageControl.numberOfPages = count
    }
    func currentPage(index: Int){
//        self.sliderPageControl.currentPage = index
    }
    func setPushVC(_ vc:UIViewController){
        self.homeImgSliderManager?.setPushVC(vc)
    }
}


class HomeImgSliderManager:NSObject,UICollectionViewDataSource,UICollectionViewDelegate{
    var data:[String]
    var controllerProtocol:SliderDelegate!
    private var willIdx: Int = 0
    private var didIdx: Int = 0
    private var pushVC: UIViewController?
    public private(set) var nowIdx: Int = 0
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeImgCollectionViewCell.identifier, for: indexPath) as! HomeImgCollectionViewCell
        cell.imgaeView.image = UIImage(named: data[indexPath.item])
        return cell
    }
    init(data:[String],updater:SliderDelegate){
        self.data = data
        self.controllerProtocol = updater
    }
    static public func createSliderCompositionalLayout(_ itemHeight: CGFloat) -> UICollectionViewLayout{
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
    //MARK: -- 배너 이미지 클릭시 이벤트 처리 메서드
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "HomeStoryboard", bundle: nil).instantiateViewController(withIdentifier: BannerVC.identifier) as! BannerVC
        self.pushVC?.navigationController?.pushViewController(vc, animated: true)
    }
    func setPushVC(_ vc: UIViewController){
        self.pushVC = vc
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
        self.data = data
    }
}

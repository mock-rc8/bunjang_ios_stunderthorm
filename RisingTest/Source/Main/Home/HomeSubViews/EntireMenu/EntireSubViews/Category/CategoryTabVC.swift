//
//  CategoryVC.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/25.
//

import Foundation
import UIKit
import OrderedCollections
class CategoryTabVC: UIViewController{
    static let identifier = "CategoryTabVC"
    @IBOutlet weak var collectionView: UICollectionView!
    lazy var sectionDict: OrderedDictionary = [
        "인기취향/취미" :
            ["골프","시계","스타굿즈","자전거","여성가방","피규어/인형",
                     "닌텐도/NDS/Wii","헬스/요가/필라테스","인테리어","자전거","CD","카메라/DSLR"],
        "중고거래" : ["여성의류","남성의류","신발","가방","시계/쥬얼리","패션 액세서리","디지털/가전","스포츠/레저","차량/오토바이","스타굿즈","키덜트","예술/희귀/수집품",
                 "음반/악기","도서/티켓/문구","뷰티/미용","가구/인테리어","생활/가공식품","유아동/출산","반려동물용품","기타","번개나눔","커뮤니티"],
        "생활" : ["지역 서비스","원룸/함께살아요","구인구직","재능"]
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: HomeCategoryCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: HomeCategoryCollectionViewCell.identifier)
        self.collectionView.register(UINib(nibName: CategoryCollectionReusableView.identifier, bundle: nil), forSupplementaryViewOfKind: "myHeader", withReuseIdentifier: CategoryCollectionReusableView.identifier)
        self.collectionView.collectionViewLayout = self.createSliderCompositionalLayout()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension CategoryTabVC: UICollectionViewDelegate,UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionDict.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.sectionDict.elements[section].value.count
    }
    //MARK: -- 셀 선택시 나오는 값
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCategoryCollectionViewCell.identifier, for: indexPath) as! HomeCategoryCollectionViewCell
        let name : String = self.sectionDict.elements[indexPath.section].value[indexPath.item]
        cell.categoryLabel.text = name
        cell.imageView.image = UIImage(named: name.replacingOccurrences(of: "/", with: ":"))
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        print("headerView Init!!")
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CategoryCollectionReusableView.identifier, for: indexPath) as? CategoryCollectionReusableView else {
            return UICollectionReusableView()
        }
        //헤더뷰의 높이 설정
       //self.headerAutoHeight = Int(headerView.Wrapper.frame.height)
        headerView.headerLabel.text = self.sectionDict.elements[indexPath.section].key
        return headerView
    }
    // 아이템 선택시 이벤트
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: CategoryMainVC.identifier) as! CategoryMainVC
        let myCate: String = self.sectionDict.values[indexPath.section][indexPath.item]
        vc.myTitle = myCate
        vc.myCategoryImg = UIImage(named: myCate.replacingOccurrences(of: "/", with: ":"))
        self.navigationController?.pushViewController(vc, animated: true)
    }
    public func createSliderCompositionalLayout() -> UICollectionViewLayout{
        //컴포지셔널 레이아웃 생성
        let layout = UICollectionViewCompositionalLayout{
            (sectionIndex: Int,layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            //아이템 사이즈 설정
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalWidth(0.20))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            //아이템 간의 간격 설정
            item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            // 그룹 사이즈 - 높이가 아이템의 크기와 같음 => 1줄이다.
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: itemSize.heightDimension)
            //그룹 사이즈로 그룹 만들기
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item,item,item])
            // 그룹으로 섹션 만들기
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 20, trailing: 20)
            //섹션 헤더와 관련된 설정
            let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(30))
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerFooterSize,
                elementKind: "myHeader",alignment: .top)
            section.boundarySupplementaryItems = [sectionHeader]
            return section
        }
        return layout
    }
}

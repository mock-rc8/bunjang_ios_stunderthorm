//
//  File.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/27.
//

import Foundation
import UIKit
class Key{
    init(){}
}
class SearchVC:UIViewController{
    @IBOutlet weak var collectionView: UICollectionView!
    static let identifer = "SearchVC"
    let searchSection: [SearchSectionName] = SearchSectionName.allCases
    let trendList = ["트리밍버드","디지몬씰","헤리티지플로스","데상트","버터플라이빈티지","전기스쿠터","이마트","서든sp","세인트제임스","부산"]
    let popularCategories = ["골프","시계","스타굿즈","자전거","여성가방","피규어/인형",
                             "닌텐도/NDS/Wii","헬스/요가/필라테스","인테리어","자전거","CD","카메라/DSLR"]
    lazy var dummyRecentSearch : [(String,Key?)] = ["아디다스 파이어버드","갤럭시탭 s7 플러스","블랙핑크 콘서트", "에어팟 맥스","쿠팡이츠"].map {($0,nil)}
    let dataManager = BrandEntireDataManager()
    let dummyBrandData = BrandEntireResult(brandIdx: 1, brandImg_url: "", brandName: "페이스북", brandEngName: "FaceBook", postNum: 123)
    var entireData: [BrandEntireResult]?
    var entireDataImg: [UIImageView]?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataManager.getItem(delegate: self)
        navigationSettings()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        //헤더
        self.collectionView.register(UINib(nibName: CategoryCollectionReusableView.identifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CategoryCollectionReusableView.identifier)
        //Footer
        self.collectionView.register(UINib(nibName: SearchFooterCollectionReusableView.identifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: SearchFooterCollectionReusableView.identifier)
        // Cell
        self.collectionView.register(UINib(nibName: RecentSearchCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: RecentSearchCollectionViewCell.identifier)
        self.collectionView.register(UINib(nibName: ItemShopCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: ItemShopCollectionViewCell.identifier)
        self.collectionView.register(UINib(nibName: SearcBrandCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: SearcBrandCollectionViewCell.identifier)
        self.collectionView.register(UINib(nibName: HomeCategoryCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: HomeCategoryCollectionViewCell.identifier)
        self.collectionView.register(UINib(nibName: TrendSearchCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: TrendSearchCollectionViewCell.identifier)
        self.collectionView.collectionViewLayout = self.createCompositionalLayout()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = true
    }
    
}

extension SearchVC: UICollectionViewDelegate,UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return searchSection.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch searchSection[indexPath.section]{
        case .brand:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearcBrandCollectionViewCell.identifier, for: indexPath) as! SearcBrandCollectionViewCell
            cell.mainImgView.image = self.entireDataImg?[indexPath.item].image ?? UIImage(named: "onboard1")
            cell.setData(self.entireData?[indexPath.item] ?? dummyBrandData)
            return cell
        case .category:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCategoryCollectionViewCell.identifier, for: indexPath) as! HomeCategoryCollectionViewCell
            cell.imageView.image = UIImage(named: popularCategories[indexPath.item].replacingOccurrences(of: "/", with: ":"))
            cell.categoryLabel.text = popularCategories[indexPath.item]
            return cell
        case .recent:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentSearchCollectionViewCell.identifier, for: indexPath) as!
            RecentSearchCollectionViewCell
            cell.closeBtnAction = { (myKey:Key,myIdxPath:IndexPath) in
                if let myItemIdx = self.dummyRecentSearch.firstIndex(where: {$0.1 === myKey}){
                    self.dummyRecentSearch.remove(at: myItemIdx)
                    let myIndexPath = IndexPath(item: myItemIdx, section: self.searchSection.firstIndex(of: .recent)!)
                    self.collectionView.deleteItems(at:[myIndexPath])
                }
                
                print(self.dummyRecentSearch,myIdxPath.item)
            }
            
            cell.myNumber = indexPath.item
            cell.myIndexPath = indexPath
            self.dummyRecentSearch[indexPath.item].1 = Key()
            cell.myKey = self.dummyRecentSearch[indexPath.item].1
            
            cell.myTitleLabel.text = self.dummyRecentSearch[indexPath.item].0
            return cell
        case .trend:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendSearchCollectionViewCell.identifier, for: indexPath) as!
            TrendSearchCollectionViewCell
            cell.numberLabel.text = indexPath.item+1 < 10 ? "0\(indexPath.item+1)" : "\(indexPath.item+1)"
            cell.productLabel.text = self.trendList[indexPath.item]
            return cell
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch searchSection[section]{
        case .trend:
            return trendList.count
        case .brand:
            return self.entireData?.count ?? 0
        case .recent:
            return self.dummyRecentSearch.count
        default:
            return 12
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let secIdx = indexPath.section
        let itemIdx = indexPath.item
        switch searchSection[secIdx]{
        case .recent:
            print("recent clicked!!")
        default:
            break
        }
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind{
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CategoryCollectionReusableView.identifier, for: indexPath) as! CategoryCollectionReusableView
            header.headerLabel.text = searchSection[indexPath.section].rawValue
            return header
        case UICollectionView.elementKindSectionFooter:
            if self.searchSection[indexPath.section] == .brand{
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SearchFooterCollectionReusableView.identifier, for: indexPath) as! SearchFooterCollectionReusableView
            return footer
            }else{
                return UICollectionReusableView()
            }
        default:
            return UICollectionReusableView()
        }
    }
    func createCompositionalLayout() -> UICollectionViewLayout{
        let layout = UICollectionViewCompositionalLayout{
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            //섹션 헤더 사이즈 설정
            let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerFooterSize,
                elementKind: UICollectionView.elementKindSectionHeader,alignment: .top)
            sectionHeader.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 0)
            switch self.searchSection[sectionIndex]{
            case .brand:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1/7))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
                let groupSize = NSCollectionLayoutSize(widthDimension: itemSize.widthDimension, heightDimension: itemSize.heightDimension)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 0, bottom: 10, trailing: 0)
                let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1/6)),
                    elementKind: UICollectionView.elementKindSectionFooter,alignment: .bottom)
                sectionFooter.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
                section.boundarySupplementaryItems = [sectionHeader,sectionFooter]
                return section
            case .category:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalWidth(0.20))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: itemSize.heightDimension)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item,item,item])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 0, bottom: 10, trailing: 20)
                section.boundarySupplementaryItems = [sectionHeader]
                return section
            case .recent:
                let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(100), heightDimension: .absolute(30))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 10)
                let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(100), heightDimension: itemSize.heightDimension)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0)
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.interGroupSpacing = 10
                section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 20, bottom: 0, trailing: 0)
                sectionHeader.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: -10, bottom: 10, trailing: 0)
                section.boundarySupplementaryItems = [sectionHeader]
                return section
            case .trend:
                let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(100), heightDimension: .absolute(35))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 10)
                let groupSize = NSCollectionLayoutSize(widthDimension: itemSize.widthDimension, heightDimension: itemSize.heightDimension)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.interGroupSpacing = 15
                section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 20, bottom: 0, trailing: 0)
                sectionHeader.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: -10, bottom: 0, trailing: 0)
                section.boundarySupplementaryItems = [sectionHeader]
                return section
            }
        }
        layout.configuration.interSectionSpacing = 100
        return layout
    }
}
//MARK: -- Navigation Bar Settings
extension SearchVC{
    func navigationSettings(){
        let searchBar = UISearchBar()
        searchBar.placeholder = "검색어를 입력해주세요"
        self.navigationItem.titleView = searchBar
        self.navigationItem.leftBarButtonItem = {
            let item = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(self.closeView))
            item.image = UIImage(systemName: "chevron.left")
            item.tintColor = .black
            return item
        }()
        self.view.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = {
            let item = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(searchView))
            item.image = UIImage(systemName: "house")
            item.tintColor = .black
            return item
        }()
    }
    @objc func closeView(){
        _ = self.navigationController?.popViewController(animated: true)
    }
    @objc func searchView(){
        self.navigationController?.popToRootViewController(animated: true)
    }
    @objc func shareView(){
        print("공유 구현 해야한다.")
    }
}
//MARK: -- 브랜드 통신 API 설정
extension SearchVC: BrandDelegate{
    func didSuccessGetItem(_ result:[BrandEntireResult]){
        print("BrandEntireVC",#function)
        let imgData : [UIImageView] = result.map{(data:BrandEntireResult) -> UIImageView in
            let imageView = UIImageView()
            print(data.brandImg_url)
            imageView.kf.setImage(with: URL(string: data.brandImg_url))
            return imageView
        }
        self.entireDataImg = Array(imgData[..<5])
        self.entireData = Array(result[..<5])
        DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
            self.collectionView.reloadData()
        }
    }
    func failedGetItem(message: String){
        presentBottomAlert(message: message,target:nil,offset: -50)
    }
}

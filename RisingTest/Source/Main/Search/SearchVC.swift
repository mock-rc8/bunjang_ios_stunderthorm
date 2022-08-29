//
//  File.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/27.
//

import Foundation
import UIKit
class SearchVC:UIViewController{
    @IBOutlet weak var collectionView: UICollectionView!
    static let identifer = "SearchVC"
    let searchSection: [SearchSectionName] = SearchSectionName.allCases
    let trendList = ["트리밍버드","디지몬씰","헤리티지플로스","데상트","버터플라이빈티지","전기스쿠터","이마트","서든sp","세인트제임스","부산"]
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationSettings()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        //헤더
        self.collectionView.register(UINib(nibName: CategoryCollectionReusableView.identifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CategoryCollectionReusableView.identifier)
        //Footer
        self.collectionView.register(UINib(nibName: SearchFooterCollectionReusableView.identifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: SearchFooterCollectionReusableView.identifier)
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
            return cell
        case .category:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCategoryCollectionViewCell.identifier, for: indexPath) as! HomeCategoryCollectionViewCell
            
            return cell
        case .recent:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentSearchCollectionViewCell.identifier, for: indexPath) as!
            RecentSearchCollectionViewCell
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
        default:
            return 12
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
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
            sectionHeader.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0)
            switch self.searchSection[sectionIndex]{
            case .brand:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1/7))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
                let groupSize = NSCollectionLayoutSize(widthDimension: itemSize.widthDimension, heightDimension: itemSize.heightDimension)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
                let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1/8)),
                    elementKind: UICollectionView.elementKindSectionFooter,alignment: .bottom)
                section.boundarySupplementaryItems = [sectionHeader,sectionFooter]
                return section
            case .category:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalWidth(0.20))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: itemSize.heightDimension)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item,item,item])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 20)
                section.boundarySupplementaryItems = [sectionHeader]
                return section
            case .recent:
                let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(100), heightDimension: .fractionalWidth(0.15))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
                let groupSize = NSCollectionLayoutSize(widthDimension: itemSize.widthDimension, heightDimension: itemSize.heightDimension)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
                section.boundarySupplementaryItems = [sectionHeader]
                return section
            case .trend:
                let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(100), heightDimension: .estimated(60))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
                let groupSize = NSCollectionLayoutSize(widthDimension: itemSize.widthDimension, heightDimension: itemSize.heightDimension)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
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

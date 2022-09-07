//
//  BrandVC.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/25.
//

import Foundation
import UIKit
class BrandHomeVC: UIViewController{
    let brandDummyData = CategoryResult(postIdx: 1, postImg_url: "naver", zzimStatus: false, price: 21231, postTitle: "어서오세요", payStatus: false)
    //브랜드 헤더 불러오기
    @IBOutlet weak var brandCollectionView: UICollectionView!
    @IBOutlet weak var mainCollectionView: UICollectionView!
    var brandManager = BrandCategoryManager()
    var brandDataList : [CategoryResult] = []
    lazy var hbScrollCollectionManager = HBScrollCollectionManager()
    static let identifier = "BrandHomeVC"
    var collectionData : [BrandSecionType] = [.brand,.append]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollCollectionSettings()
        self.mainCollectionView.delegate = self
        self.mainCollectionView.dataSource = self
        self.brandManager.getNewData(myIdx: 7, delegate: self)
        // Header
        self.mainCollectionView.register(UINib(nibName: BrandAppendHeader.identifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: BrandAppendHeader.identifier)
        self.mainCollectionView.register(UINib(nibName: BrandFollowHeader.identifier, bundle: nil),forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: BrandFollowHeader.identifier)
        // Footer
        self.mainCollectionView.register(UINib(nibName: SearchFooterCollectionReusableView.identifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: SearchFooterCollectionReusableView.identifier)
        // Cell
        self.mainCollectionView.register(UINib(nibName: SuggestMainCell.identifier, bundle: nil), forCellWithReuseIdentifier: SuggestMainCell.identifier)
        self.mainCollectionView.register(UINib(nibName: SubScribeSuggestCell.identifier, bundle: nil), forCellWithReuseIdentifier: SubScribeSuggestCell.identifier)
        self.mainCollectionView.collectionViewLayout = self.createCompositionalLayout()
    }
}
extension BrandHomeVC: UICollectionViewDelegate,UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.collectionData.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch self.collectionData[indexPath.section]{
        case .append:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SuggestMainCell.identifier, for: indexPath) as! SuggestMainCell
            cell.myVC = self
            cell.setCollectionView(self.view.frame.width)
            return cell
        case .brand:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SubScribeSuggestCell.identifier, for: indexPath) as! SubScribeSuggestCell
            //MARK: -- 서버 수정
            let myData = brandDataList[indexPath.item]
            cell.setData(myData)
            cell.titleImg.kf.setImage(with: URL(string: myData.postImg_url))
            cell.myParentVC = self
            cell.pushDelegate = { idx in
                let nextVC = UIStoryboard(name: "HomeStoryboard", bundle: nil).instantiateViewController(withIdentifier: ItemVC.identifer) as! ItemVC
                nextVC.myPostIdx = idx
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
//            cell.setData(self.brandDummyData)
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SuggestMainCell.identifier, for: indexPath) as! SuggestMainCell
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionData[section]{
        case .brand:
            //MARK: -- 서버 연걸 수정!!
            return brandDataList.count
            //return 12
        case .append:
            return 1
        default:
            return 20
        }
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch self.collectionData[indexPath.section]{
        case .append:
            switch kind{
            case UICollectionView.elementKindSectionHeader:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: BrandAppendHeader.identifier, for: indexPath) as! BrandAppendHeader
                header.myVC = self
                return header
            default:
                return UICollectionReusableView()
            }
        case .brand:
            switch kind{
            case UICollectionView.elementKindSectionHeader:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: BrandFollowHeader.identifier, for: indexPath) as! BrandFollowHeader
                header.followBtn.isHidden = true
                return header
            case UICollectionView.elementKindSectionFooter:
                let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SearchFooterCollectionReusableView.identifier, for: indexPath) as! SearchFooterCollectionReusableView
                footer.btnView.setTitle("나이키 브랜드 모두보기", for: .normal)
                return footer
            default:
                return UICollectionReusableView()
            }
        default:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CateMainCollectionReusableView.identifier, for: indexPath) as! CateMainCollectionReusableView
            return header
        }
    }
    func createCompositionalLayout() -> UICollectionViewLayout{
        let layout = UICollectionViewCompositionalLayout{
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            switch self.collectionData[sectionIndex]{
            case .append:
                // 아이템에 대한 사이즈 - absolute는 고정값, estimated는 추측, fraction 퍼센트
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(350))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                // 아이템 간의 간격 설정
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
                // 그룹 사이즈
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: itemSize.heightDimension)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                // 그룹으로 섹션 만들기
                let section = NSCollectionLayoutSection(group: group)
                // 섹션에 대한 간격 설정
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
                //section.orthogonalScrollingBehavior = .continuous
                //섹션 헤더와 관련된 설정
                let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))
                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerFooterSize,
                    elementKind: UICollectionView.elementKindSectionHeader,alignment: .top)
                section.boundarySupplementaryItems = [sectionHeader]
                return section
            case .brand:
                // 아이템에 대한 사이즈 - absolute는 고정값, estimated는 추측, fraction 퍼센트
                //.absolute(self.view.frame.width)
                let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(self.view.frame.width), heightDimension: .absolute(180))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                // 아이템 간의 간격 설정
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
                // 그룹 사이즈
                let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(self.view.frame.width), heightDimension: itemSize.heightDimension)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                // 그룹으로 섹션 만들기
                let section = NSCollectionLayoutSection(group: group)
                // 섹션에 대한 간격 설정
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
                //섹션 헤더와 관련된 설정
                let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(60))
                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerFooterSize,
                    elementKind: UICollectionView.elementKindSectionHeader,alignment: .top)
                sectionHeader.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0)
                let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50)),
                    elementKind: UICollectionView.elementKindSectionFooter,alignment: .bottom)
                sectionFooter.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
                section.boundarySupplementaryItems = [sectionHeader,sectionFooter]
                return section
            default:
                // 아이템에 대한 사이즈 - absolute는 고정값, estimated는 추측, fraction 퍼센트
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(600))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                // 아이템 간의 간격 설정
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
                // 그룹 사이즈
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: itemSize.heightDimension)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item,item,item])
                // 그룹으로 섹션 만들기
                let section = NSCollectionLayoutSection(group: group)
                // 섹션에 대한 간격 설정
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
                //섹션 헤더와 관련된 설정
                let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))
                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerFooterSize,
                    elementKind: UICollectionView.elementKindSectionHeader,alignment: .top)
                sectionHeader.pinToVisibleBounds = true
                section.boundarySupplementaryItems = [sectionHeader]
                return section
            }
            
        }
        return layout
    }
}
//MARK: -- 메인셀 로드 완료
extension BrandHomeVC{
    func didSuccessGetItem(_ result: [CategoryResult]){
        self.brandDataList = result
        self.mainCollectionView.reloadData()
    }
    func didFailedGetResult(message: String){
        print("불러오기 오류!!")
    }
}

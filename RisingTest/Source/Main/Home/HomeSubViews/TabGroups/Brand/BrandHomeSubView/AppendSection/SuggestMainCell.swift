//
//  SuggestMainCell.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/30.
//

import UIKit

class SuggestMainCell: UICollectionViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    static let identifier = "SuggestMainCell"
    var myVC : UIViewController?
    lazy var suggestMainCollectionManager = SuggestMainCollectionManager()
    var scrollDataList: [CategoryResult] = []
    var categoryFisrtManager = SuggestCategoryManager()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.categoryFisrtManager.getNewData(myIdx: 1, delegate: self)
    }
    func setCollectionView(_ width: CGFloat){
        suggestMainCollectionManager.myDelegate = self
        self.collectionView.delegate = suggestMainCollectionManager
        self.collectionView.dataSource = suggestMainCollectionManager
        self.collectionView.collectionViewLayout = suggestMainCollectionManager.createSliderCompositionalLayout(width)
        self.collectionView.register(UINib(nibName: BrandFollowHeader.identifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: BrandFollowHeader.identifier)
        self.collectionView.register(UINib(nibName: BrandSuggestCell.identifier, bundle: nil), forCellWithReuseIdentifier: BrandSuggestCell.identifier)
        self.collectionView.isScrollEnabled = false
    }
}
//MARK: -- 메인셀 로드 완료
extension SuggestMainCell{
    func didSuccessGetItem(_ result: [CategoryResult]){
        self.scrollDataList = result
        self.collectionView.reloadData()
    }
    func didFailedGetResult(message: String){
        print("불러오기 오류!!")
    }
}

class SuggestMainCollectionManager:NSObject,UICollectionViewDataSource,UICollectionViewDelegate{
    var myDelegate: SuggestMainCell?
    var myCollection: UICollectionView?
    var myVC: UIViewController?
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myDelegate?.scrollDataList.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BrandSuggestCell.identifier, for: indexPath) as! BrandSuggestCell
        let idx = indexPath.item
        if let myData = myDelegate?.scrollDataList[idx]{
            cell.titleLabel.text = myData.postTitle
            cell.priceLabel.text = "\(myData.price)원"
            cell.titleImgView.kf.setImage(with: URL(string: myData.postImg_url))
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("isSelected!!")
        let vc = UIStoryboard(name: "HomeStoryboard", bundle: nil).instantiateViewController(withIdentifier: ItemVC.identifer) as! ItemVC
        vc.myPostIdx = (self.myDelegate?.scrollDataList[indexPath.item].postIdx)!
        self.myDelegate?.myVC?.navigationController?.pushViewController(vc, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind{
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: BrandFollowHeader.identifier, for: indexPath) as! BrandFollowHeader
            header.brandImgView.image = UIImage(named: "appleLogo")
            header.brandImgView.tintColor = .black
            header.brandTitleLabel.text = "애플"
            header.brandSubTitleLabel.text = "Apple"
            header.likesCountLabel.text = "17777777"
            return header
        default:
            return UICollectionReusableView()
        }
    }
    func createSliderCompositionalLayout(_ width: CGFloat) -> UICollectionViewLayout{
        //컴포지셔널 레이아웃 생성
        let layout = UICollectionViewCompositionalLayout{
            (sectionIndex: Int,layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            //아이템 사이즈 설정
            let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(width/2.5), heightDimension: .estimated(width/2))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
            let groupSize = NSCollectionLayoutSize(widthDimension: itemSize.widthDimension, heightDimension: itemSize.heightDimension)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0)
            // 수평 스크롤 섹션 만들기
            section.orthogonalScrollingBehavior = .continuous
            //섹션 헤더 사이즈 설정
            let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(60))
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerFooterSize,
                elementKind: UICollectionView.elementKindSectionHeader,alignment: .top)
            sectionHeader.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            section.boundarySupplementaryItems = [sectionHeader]
            return section
        }
        return layout
    }
}

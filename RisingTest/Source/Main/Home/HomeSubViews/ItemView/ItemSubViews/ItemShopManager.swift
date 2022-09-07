//
//  ItemShopManager.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/26.
//

import UIKit
import Foundation
class ItemShopManager:NSObject,UICollectionViewDataSource,UICollectionViewDelegate{
    var myVC : UIViewController?
    var data: [RecommendResult] = Dummy.SHOP_LIST
    var isCellInit = true
    var heightMethod : ((_ height: CGFloat)->Void)?
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemShopCollectionViewCell.identifier, for: indexPath) as! ItemShopCollectionViewCell
        if isCellInit {
            self.heightMethod!(cell.frame.height)
            isCellInit.toggle()
        }
        let data = self.data[indexPath.item]
        cell.safePayView.isHidden = !data.payStatus
        cell.priceLabel.text = Variable.getMoneyFormat(data.price)
        cell.titleLabel.text = data.postTitle
        cell.dataLabel.text = data.postingTime
        cell.locationLabel.text = data.tradeRegion ?? "지역정보 없음"
        cell.mainImg.kf.setImage(with: URL(string: data.postImg_url ?? "onboard1"))
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = self.data[indexPath.item]
        let nextVC = UIStoryboard(name: "HomeStoryboard", bundle: nil).instantiateViewController(withIdentifier: ItemVC.identifer) as! ItemVC
        nextVC.myPostIdx = data.postIdx
        self.myVC?.navigationController?.pushViewController(nextVC, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        print("headerView Init!!")
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ItemHeaderCollectionReusableView.identifier, for: indexPath) as? ItemHeaderCollectionReusableView else {
            return UICollectionReusableView()
        }
        //헤더뷰의 높이 설정
       //self.headerAutoHeight = Int(headerView.Wrapper.frame.height)
        headerView.headerLabel.font = .systemFont(ofSize: 18, weight: .bold)
        headerView.headerLabel.text = "이 상점의 상품"
        return headerView
    }
    static public func createCompositionalLayout() -> UICollectionViewLayout{
        let layout = UICollectionViewCompositionalLayout{
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            // 아이템에 대한 사이즈 - absolute는 고정값, estimated는 추측, fraction 퍼센트
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .estimated(250))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            // 아이템 간의 간격 설정
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
            // 그룹 사이즈
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: itemSize.heightDimension)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item,item,item])
            // 그룹으로 섹션 만들기
            let section = NSCollectionLayoutSection(group: group)
            // 섹션에 대한 간격 설정
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: -5, bottom: 0, trailing: 0)
            //섹션 헤더와 관련된 설정
            let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(30))
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerFooterSize,
                elementKind: "myHeader",alignment: .top)
            sectionHeader.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 10, trailing: 0)
            section.boundarySupplementaryItems = [sectionHeader]
            return section
        }
        return layout
    }
    func setData(data:[RecommendResult]){
        self.data = data
    }
    
}
class ItemShopHeader: UITableViewHeaderFooterView {
    static let identifier = "ItemShopHeader"
    var text :String = "" {
        willSet{
            self.label.text = newValue
        }
    }
    private let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 21, weight: .bold)
        label.textAlignment = .left
        return label
    }()
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(label)
    }
    required init?(coder: NSCoder) {
        fatalError("is init error")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        label.sizeToFit()
        label.frame = CGRect(x: 20, y: 0, width: contentView.frame.width, height: contentView.frame.height)
    }
}

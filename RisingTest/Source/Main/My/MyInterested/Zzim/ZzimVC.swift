//
//  zzimVC.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/09/05.
//

import Foundation
import UIKit
class ZzimVC: UIViewController{
    @IBOutlet weak var collectionView: UICollectionView!
    static let identifier = "ZzimVC"
    lazy var zzimDataManager = ZzimDataManager()
    var zzimResults: [ZzimResult]?
    override func viewDidLoad() {
        super.viewDidLoad()
        zzimDataManager.getZiimData(delegate: self)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: ZzimCell.identifier, bundle: nil), forCellWithReuseIdentifier: ZzimCell.identifier)
        self.collectionView.collectionViewLayout = self.createCompositionalLayout()
    }
}
extension ZzimVC: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //MARK: -- 서버 열리면 수정
        return zzimResults?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZzimCell.identifier, for: indexPath) as! ZzimCell
        let data = zzimResults?[indexPath.item]
        if let imgURL = data?.postImg_url{
            cell.itemImg.kf.setImage(with: URL(string: imgURL))
        }else{
            cell.itemImg.image = UIImage(systemName: "photo.artframe")
            cell.itemImg.tintColor = .lightGray
        }
        
        cell.priceLabel.text = "\(data!.price) 원"
        cell.safePay.isHidden = true
        cell.uploadDate.text = data?.createdAt
        cell.titleLabel.text = data?.userName
        return cell
    }

    fileprivate func createCompositionalLayout() -> UICollectionViewLayout{
        let layout = UICollectionViewCompositionalLayout{
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            // 아이템에 대한 사이즈 - absolute는 고정값, estimated는 추측, fraction 퍼센트
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2), heightDimension: .estimated(200))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            // 아이템 간의 간격 설정
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
            // 그룹 사이즈
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: itemSize.heightDimension)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item,item])
            // 그룹으로 섹션 만들기
            let section = NSCollectionLayoutSection(group: group)
            // 섹션에 대한 간격 설정
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            //섹션 헤더와 관련된 설정
            return section
        }
        return layout
    }
}
extension ZzimVC{
    func didSuccessGetItem(_ results: [ZzimResult]){
        self.zzimResults = results
        self.collectionView.reloadData()
    }
    func failedToRequest(message: String){
        presentAlert(title: message)
    }
}

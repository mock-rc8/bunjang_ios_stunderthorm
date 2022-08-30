//
//  HomeBrandScrollCollectionManager.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/30.
//

import Foundation

import Foundation
import UIKit
extension BrandHomeVC{
    func scrollCollectionSettings(){
        self.hbScrollCollectionManager.myVC = self
        self.hbScrollCollectionManager.myCollection = self.brandCollectionView
        self.brandCollectionView.delegate = self.hbScrollCollectionManager
        self.brandCollectionView.dataSource = self.hbScrollCollectionManager
        self.brandCollectionView.register(UINib(nibName: BHScrollCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: BHScrollCollectionViewCell.identifier)
    }
}
class HBScrollCollectionManager:NSObject,UICollectionViewDataSource,UICollectionViewDelegate{
    var scrollData: [ScrollData] = [ScrollData(type: .append, title: "추가"),ScrollData(type: .append, title: "추가"),ScrollData(type: .edit, title: "편집")]
    var isClicked: [Bool]
    var myVC: UIViewController?
    var myCollection: UICollectionView?
    override init() {
        self.isClicked = self.scrollData.map{_ in false}
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return scrollData.count
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let idx = indexPath.item
        switch scrollData[idx]{
        case (type: .edit, _):
            let vc = UIStoryboard(name: "EntireMenuStoryboard", bundle: nil).instantiateViewController(withIdentifier: BrandEntireVC.identifier) as! BrandEntireVC
            vc.isHomeCalled = true
            myVC?.navigationController?.pushViewController(vc, animated: true)
            break
        default:
            print("isclicked!!")
            self.isClicked = self.isClicked.map{ _ in false }
            self.isClicked[idx] = true
            myCollection?.reloadData()
            break
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BHScrollCollectionViewCell.identifier, for: indexPath) as! BHScrollCollectionViewCell
        let idx = indexPath.item
        cell.scrollBtn.setTitle(scrollData[idx].title, for: .normal)
        if isClicked[idx]{
            cell.scrollBtn.setTitleColor(.red, for: .normal)
            //cell.scrollBtn.titleLabel?.textColor = .red
        }else{
            cell.scrollBtn.setTitleColor(.black, for: .normal)
        }
        switch scrollData[idx]{
        case (type: .append, _):
            return cell
        case (type: .edit, _):
            return cell
        default:
            return cell
        }
    }
    func createSliderCompositionalLayout(_ height: CGFloat) -> UICollectionViewLayout{
        //컴포지셔널 레이아웃 생성
        let layout = UICollectionViewCompositionalLayout{
            (sectionIndex: Int,layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            //아이템 사이즈 설정
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            let groupSize = NSCollectionLayoutSize(widthDimension: itemSize.widthDimension, heightDimension: itemSize.heightDimension)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            // 수평 스크롤 섹션 만들기
            section.orthogonalScrollingBehavior = .continuous
            return section
        }
        return layout
    }
}
//struct ScrollData{
//    var type: ScrollBtnType
//    var title: String
//}

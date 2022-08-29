//
//  CategoryMainVC.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/25.
//

import Foundation
import UIKit
class CategoryMainVC: UIViewController{
    static let identifier = "CategoryMainVC"
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewTop: NSLayoutConstraint!
    var header: CateMainCollectionReusableView?
    var wrapperHeight : CGFloat?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(UINib(nibName: ItemShopCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: ItemShopCollectionViewCell.identifier)
        self.collectionView.register(UINib(nibName: CateMainCollectionReusableView.identifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CateMainCollectionReusableView.identifier)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.collectionViewLayout = createCompositionalLayout()
        navigationSettings()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.wrapperHeight = self.wrapperHeight ?? ((self.header?.headerWrapper.frame.height)! + self.topbarHeight)
        print("navi Height",self.topbarHeight)
    }
}

extension CategoryMainVC: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemShopCollectionViewCell.identifier, for: indexPath) as! ItemShopCollectionViewCell
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        if let wrapperHeight = self.wrapperHeight{
        let isOverWrapperHeight = Int(y) > Int(wrapperHeight)
        print(wrapperHeight)
            DispatchQueue.main.async {
                self.collectionViewTop.constant = isOverWrapperHeight ?  -wrapperHeight : -y
                print(self.collectionViewTop.constant)
                self.collectionView.layoutIfNeeded()
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CateMainCollectionReusableView.identifier, for: indexPath) as! CateMainCollectionReusableView
        self.header = header

        return header
    }
    func createCompositionalLayout() -> UICollectionViewLayout{
        let layout = UICollectionViewCompositionalLayout{
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            // 아이템에 대한 사이즈 - absolute는 고정값, estimated는 추측, fraction 퍼센트
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalWidth(2.2/3))
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
        return layout
    }
}
//MARK: -- 네비게이션 관리
extension CategoryMainVC{
    func navigationSettings(){
        self.navigationItem.leftBarButtonItem = {
            let item = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(self.closeView))
            item.image = UIImage(systemName: "chevron.left")
            item.tintColor = .black
            return item
        }()
        self.navigationItem.rightBarButtonItems = [{
            let item = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(self.closeViewRootVC))
            item.image = UIImage(systemName: "house")
            item.tintColor = .black
            return item
        }(),{
            let item = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(self.searchVC))
            item.image = UIImage(systemName: "magnifyingglass")
            item.tintColor = .black
            return item
        }()]
    }
    @objc func closeView(){
        self.navigationController?.popViewController(animated: true)
    }
    @objc func closeViewRootVC() {
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromBottom
        navigationController?.view.layer.add(transition, forKey: nil)
        //_ = navigationController?.popViewController(animated: false)
        self.navigationController?.popToRootViewController(animated: false)
    }
    @objc func searchVC(){
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: SearchVC.identifer) as! SearchVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

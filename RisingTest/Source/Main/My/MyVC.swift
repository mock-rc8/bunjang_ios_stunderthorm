//
//  MyVC.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/27.
//

import Foundation
import UIKit

class MyVC: MainUIViewController{
    
    // 데이터
    var myDataManager = MyDataManager()
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewTop: NSLayoutConstraint!
    static let identifier = "MyVC"
    var itemList: [MyItem] = MyItem.allCases
    lazy var myNumberManager = MyNumberManager()
    lazy var myInfoManager = MyInfoManager()
    var wrapperHeight : CGFloat?
    var header: MyHeaderCollectionReusableView?
    lazy var myCountNumber: [Int] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myDataManager.getItem(delegate: self)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = createSliderCompositionalLayout()
        collectionView.register(UINib(nibName: MyHeaderCollectionReusableView.identifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MyHeaderCollectionReusableView.identifier)
        collectionView.register(UINib(nibName: MyNoticeCollectionReusableView.identifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: MyNoticeCollectionReusableView.identifier)
        collectionView.register(UINib(nibName: MyTabManCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: MyTabManCollectionViewCell.identifier)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView.reloadData()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.wrapperHeight = self.wrapperHeight ?? ((header?.headerWrapper.frame.height)! + self.topbarHeight)
        
        
    }
    @IBAction func alertBtnAction(_ sender: UIBarButtonItem) {
        let vc = UIStoryboard(name: "AlertStoryboard", bundle: nil).instantiateViewController(withIdentifier: AlertVC.identifier) as! AlertVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func SettingBtnAction(_ sender: UIBarButtonItem) {
        let vc = UIStoryboard(name: "SettingStoryboard", bundle: nil).instantiateViewController(withIdentifier: SettingModalVC.identifier) as! SettingModalVC
        vc.completion = {
            let vc = UIStoryboard(name: "SettingStoryboard", bundle: nil).instantiateViewController(withIdentifier: SettingEntireVC.identifier) as! SettingEntireVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
        presentPanModal(vc)
    }
}
extension MyVC: UICollectionViewDataSource,UICollectionViewDelegate{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyTabManCollectionViewCell.identifier, for: indexPath) as! MyTabManCollectionViewCell
        
            return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind{
        case UICollectionView.elementKindSectionFooter:
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MyNoticeCollectionReusableView.identifier, for: indexPath) as! MyNoticeCollectionReusableView
            return footer
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MyHeaderCollectionReusableView.identifier, for: indexPath) as! MyHeaderCollectionReusableView
            header.myVC = self
            header.headerTitle.text = Variable.USER_NAME
        self.infoSettings(header.shopInfoCollection)
        self.numberInfoSettings(header.numberCollection)
        
        self.header = header
        return header
        default:
            return UICollectionReusableView()
        }
    }
    func createSliderCompositionalLayout() -> UICollectionViewLayout{
        //컴포지셔널 레이아웃 생성
        let layout = UICollectionViewCompositionalLayout{
            (sectionIndex: Int,layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            //아이템 사이즈 설정
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(16/9))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: itemSize.heightDimension)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            //섹션 헤더 사이즈 설정
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,alignment: .top)
            sectionHeader.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0)
            //sectionHeader.pinToVisibleBounds = true
            // 섹션 Footer 사이즈 설정
            let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(400))
            let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: footerSize,
                elementKind: UICollectionView.elementKindSectionFooter,alignment: .bottom)
            sectionFooter.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0)
            section.boundarySupplementaryItems = [sectionHeader,sectionFooter]
            return section
        }
        return layout
    }
}
//MARK: -- 마이 스크롤 액션
extension MyVC:UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        if let wrapperHeight = self.wrapperHeight{
            let isOverWrapperHeight = Float(y) > (100)
        print(wrapperHeight)
//            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0, options: [], animations: {
//                self.collectionViewTop.constant = isOverWrapperHeight ?  -wrapperHeight : -y
//                if !isOverWrapperHeight{
//                    //self.header?.heightAnchor.constraint(equalToConstant: -y)
//                    collectionView.collectionViewLayout.pinto
//                }
//                print(self.collectionViewTop.constant)
//
//            })
            //self.collectionView.layoutIfNeeded()
        }
    }

}
//MARK: -- 헤더 컬렉션 뷰
extension MyVC{
    func numberInfoSettings(_ numberInfoCollectionView: UICollectionView){
        self.myNumberManager.myCollectionView = numberInfoCollectionView
        numberInfoCollectionView.delegate = self.myNumberManager
        numberInfoCollectionView.dataSource = self.myNumberManager
        numberInfoCollectionView.register(UINib(nibName: MyNumberCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: MyNumberCollectionViewCell.identifier)
        numberInfoCollectionView.collectionViewLayout = self.myNumberManager.createSliderCompositionalLayout(numberInfoCollectionView.frame.height)
    }
    func infoSettings(_ shopInfoCollectionView: UICollectionView){
        shopInfoCollectionView.delegate = self.myInfoManager
        shopInfoCollectionView.dataSource = self.myInfoManager
        shopInfoCollectionView.register(UINib(nibName: MyInfoCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: MyInfoCollectionViewCell.identifier)
        shopInfoCollectionView.collectionViewLayout = self.myInfoManager.createSliderCompositionalLayout(shopInfoCollectionView.frame.height)
    }
}
// MARK: -- MyNumber 데이터
extension MyVC{
    func failedGetItem(message: String){
        
    }
    func didSuccessGetItem(_ result: MyResult){
        self.myCountNumber = [result.zzim_num,result.review_num,result.follower_num,result.following_num]
        print(self.myCountNumber)
        self.myNumberManager.setData(myDataNumber: self.myCountNumber)
    }
}

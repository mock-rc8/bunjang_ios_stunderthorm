//
//  RecommendTabVC.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/24.
//

import Foundation
import UIKit
extension Notification.Name{
    static let ScrollEnabled = Notification.Name("ScrollEnabled")
    static let ScrollDisabld = Notification.Name("ScrollDisabled")
}
class RecommendTabVC: UIViewController{
    @IBOutlet weak var collectionView: UICollectionView!
    static let identifier = "RecommendTabVC"
    var lastScroll:CGFloat = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.collectionView.register(UINib(nibName: RecommendCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier:RecommendCollectionViewCell.identifier)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.collectionViewLayout = self.createCompositionalLayout()
        NotificationCenter.default.addObserver(self, selector: #selector(isScrollable(notification:)), name: Notification.Name.ScrollEnabled, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(isScrolldisable(notification:)), name: Notification.Name.ScrollDisabld, object: nil)
    }
    @objc func isScrollable(notification: Notification?){
        DispatchQueue.main.async {
            self.collectionView.isScrollEnabled = true
            self.collectionView.contentOffset.y = 1
        }
        print("notificationcenter scrollable")
    }
    @objc func isScrolldisable(notification: Notification?){
        DispatchQueue.main.async {
            self.collectionView.isScrollEnabled = false
        }
        print("notificationcenter")
    }
    deinit{
        NotificationCenter.default.removeObserver(self, name: Notification.Name.ScrollDisabld, object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name.ScrollEnabled, object: nil)
    }
}
extension RecommendTabVC:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendCollectionViewCell.identifier, for: indexPath) as! RecommendCollectionViewCell
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nextVC =  self.storyboard?.instantiateViewController(withIdentifier: ItemVC.identifer) as! ItemVC
        navigationController?.pushViewController(nextVC, animated: true)
    }
    fileprivate func createCompositionalLayout() -> UICollectionViewLayout{
        let layout = UICollectionViewCompositionalLayout{
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            // 아이템에 대한 사이즈 - absolute는 고정값, estimated는 추측, fraction 퍼센트
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalWidth(0.5))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            // 아이템 간의 간격 설정
            item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
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
extension RecommendTabVC:UIScrollViewDelegate{
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        if y <= lastScroll {
            if y == 0 {
                DispatchQueue.main.async {
                    self.collectionView.isScrollEnabled = false
                    NotificationCenter.default.post(name: Notification.Name.ScrollToTop,object: nil,userInfo:nil)
                }
                
                
                
            }
        }
        self.lastScroll = y
    }
}

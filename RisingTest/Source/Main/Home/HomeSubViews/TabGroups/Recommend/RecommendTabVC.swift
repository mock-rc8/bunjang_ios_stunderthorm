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
    let dummyData = RecommendResult(postIdx: 2, postImg_url: nil, zzimStatus: true, price: 23122, postTitle: "안녕하세요", tradeRegion: "경기도 구리", postingTime: "2달전", payStatus: false, likeNum: 321, sellingStatus: "N")
    @IBOutlet weak var collectionView: UICollectionView!
    static let identifier = "RecommendTabVC"
    var lastScroll:CGFloat = 0
    var dataModel: HomeRecommendModel?
    var isViewAppeared: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataModel = HomeRecommendModel(reload: self)
        self.dataModel!.addMyData()
        // Do any additional setup after loading the view.
        self.collectionView.register(UINib(nibName: RecommendCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier:RecommendCollectionViewCell.identifier)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.collectionViewLayout = self.createCompositionalLayout()
        NotificationCenter.default.addObserver(self, selector: #selector(isScrollable(notification:)), name: Notification.Name.ScrollEnabled, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(isScrolldisable(notification:)), name: Notification.Name.ScrollDisabld, object: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.isViewAppeared = true
        if dataModel!.nowListCount == 0 {
            self.dataModel?.addMyData()
        }
        self.collectionView.reloadData() 
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.isViewAppeared = false
    }
    @objc func isScrollable(notification: Notification?){
        DispatchQueue.main.async {
            self.collectionView.isScrollEnabled = true
            self.collectionView.contentOffset.y = 1
        }
    }
    @objc func isScrolldisable(notification: Notification?){
        DispatchQueue.main.async {
            self.collectionView.isScrollEnabled = false
        }
    }
    deinit{
        NotificationCenter.default.removeObserver(self, name: Notification.Name.ScrollDisabld, object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name.ScrollEnabled, object: nil)
    }

}
//MARK: -- Recommend 무한 스크롤 데이터 얻기
extension RecommendTabVC:ReloadProtocol{
    func reload() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.collectionView.performBatchUpdates(nil, completion: {_ in
                self.collectionView.reloadData()
            })
        }
    }
    func didSuccessGetResult(){
        
    }
    func didFailedGetResult(message: String){
        //self.presentBottomAlert(message: message)
        self.presentBottomAlert(message: message, target: nil, offset: -200)
        //MARK: -- 서버 API
//        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
//            print(self.isViewLoaded)
//            if self.isViewAppeared {
//            self.dataModel?.addMyData()
//            }
//        }
    }
}
extension RecommendTabVC:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //MARK: -- 서버 열리면 수정
        return dataModel!.nowListCount
        //return 60
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendCollectionViewCell.identifier, for: indexPath) as! RecommendCollectionViewCell
        let idx = indexPath.item
        if idx < self.dataModel?.data.count ?? 0, let data: RecommendResult = self.dataModel?.data[idx], let imgView:UIImageView = self.dataModel?.dataImg[idx] {
            cell.headImgView.image = imgView.image
            cell.setData(data)
        }else{
            cell.setData(dummyData)
        }
        cell.tapDelegate = { postIdx in
                let nextVC =  self.storyboard?.instantiateViewController(withIdentifier: ItemVC.identifer) as! ItemVC
                //MARK: -- 서버 열리면 수정!!
                nextVC.myPostIdx = self.dataModel?.data[indexPath.item].postIdx ?? -1
                //nextVC.myPostIdx = postIdx
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
        if(idx + 6 == self.dataModel?.nowListCount){self.dataModel?.addMyData()}
        return cell
    }
    fileprivate func createCompositionalLayout() -> UICollectionViewLayout{
        let layout = UICollectionViewCompositionalLayout{
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            // 아이템에 대한 사이즈 - absolute는 고정값, estimated는 추측, fraction 퍼센트
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalWidth(1.0))
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
//MARK: --  스티키 헤더 구현
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

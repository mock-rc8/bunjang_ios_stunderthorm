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
    //통신 API
    var dataModel : CategoryModel?
    let dummyData : CategoryResult = CategoryResult(postIdx: 3, postImg_url: "", zzimStatus: true, price: 32000, postTitle: "팝니다", payStatus: true)
    // 스티키 헤더
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewTop: NSLayoutConstraint!
    var header: CateMainCollectionReusableView?
    var wrapperHeight : CGFloat?
    var myCategoryImg :UIImage?
    var myTitle : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: -- 서버 연결시
        let myNumber = myTitle == "신발" ? 3 : myTitle == "디지털/가전" ? 7 : -1
        self.dataModel = CategoryModel(myIdx: myNumber, reload: self)
        self.dataModel!.addMyData()
        self.showIndicator()
        
        self.collectionView.register(UINib(nibName: BrandSuggestCell.identifier, bundle: nil), forCellWithReuseIdentifier: BrandSuggestCell.identifier)
        self.collectionView.register(UINib(nibName: CateMainCollectionReusableView.identifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CateMainCollectionReusableView.identifier)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.collectionViewLayout = createCompositionalLayout()
        NotificationCenter.default.addObserver(self, selector: #selector(zzimOn(notification:)), name: Notification.Name.ZzimOn, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(zzimOff(notification:)), name: Notification.Name.ZzimOff, object: nil)
        navigationSettings()
        print(myTitle ?? "없음")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if dataModel?.nowListCount == 0 {
            self.dataModel?.addMyData()
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.wrapperHeight = self.wrapperHeight ?? ((self.header?.headerWrapper.frame.height)! + self.topbarHeight)
        print("navi Height",self.topbarHeight)
    }
    deinit{
        NotificationCenter.default.removeObserver(self, name: Notification.Name.ZzimOn, object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name.ZzimOff, object: nil)
    }
}
//MARK: -- 노티피케이션 설정
extension CategoryMainVC{
    @objc func zzimOn(notification: Notification){
        self.presentBottomAlert(message: "찜 목록에 추가되었어요!")
    }
    @objc func zzimOff(notification: Notification){
        self.presentBottomAlert(message: "찜 해제가 완료되었습니다.")
    }
}
// MARK: -- 컬렉션 뷰 설정
extension CategoryMainVC: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let idx = indexPath.item
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BrandSuggestCell.identifier, for: indexPath) as! BrandSuggestCell
        //MARK: -- 서버 연결 필요
        cell.setData((self.dataModel?.data[indexPath.item])!)
        cell.titleImgView.image = self.dataModel?.dataImgView[indexPath.item].image ?? UIImage(named: "onboard1")
        //cell.setData(dummyData)
        if(idx + 6 == self.dataModel?.nowListCount){self.dataModel?.addMyData()}
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nextVC = UIStoryboard(name: "HomeStoryboard", bundle: nil).instantiateViewController(withIdentifier: ItemVC.identifer) as! ItemVC
        //MARK: -- 서버 열리면 수정!!
        nextVC.myPostIdx = self.dataModel?.data[indexPath.item].postIdx ?? -1
        //nextVC.myPostIdx = 12
        navigationController?.pushViewController(nextVC, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //MARK: -- 서버연결 필요
        //return 30
        return self.dataModel?.data.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CateMainCollectionReusableView.identifier, for: indexPath) as! CateMainCollectionReusableView
        self.header = header
        header.categoryImg.image = myCategoryImg ?? UIImage(named: "onboard1")
        header.categoryTitle.text = myTitle ?? "번개장터 카테고리"
        return header
    }
    func createCompositionalLayout() -> UICollectionViewLayout{
        let layout = UICollectionViewCompositionalLayout{
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            // 아이템에 대한 사이즈 - absolute는 고정값, estimated는 추측, fraction 퍼센트
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .estimated(300))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            // 아이템 간의 간격 설정
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
            // 그룹 사이즈
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: itemSize.heightDimension)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item,item,item])
            group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 13, bottom: 10, trailing: 13)
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
//MARK: -- 스티키 헤더
extension CategoryMainVC{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        if let wrapperHeight = self.wrapperHeight{
        let isOverWrapperHeight = Int(y) > Int(wrapperHeight)
        print(wrapperHeight)
            DispatchQueue.main.async {
                self.collectionViewTop.constant = isOverWrapperHeight ?  -wrapperHeight : -y
                self.collectionView.layoutIfNeeded()
            }
        }
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
//MARK: -- Categoty 무한 스크롤 데이터 얻기
extension CategoryMainVC:ReloadProtocol{
    func reload() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.collectionView.performBatchUpdates(nil, completion: {_ in
                self.collectionView.reloadData()
            })
        }
    }
    func didSuccessGetResult(){
        self.dismissIndicator()
        if self.dataModel?.data.count == 0{
            didFailedGetResult(message: "알 수 없는 오류")
        }
    }
    func didFailedGetResult(message: String){
        self.presentAlert(title: message,message: "나중에 다시 시도하세요.") { action in
            self.navigationController?.popViewController(animated: true)
        }
        //MARK: -- 서버 API
//        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
//            print(self.isViewLoaded)
//            if self.isViewAppeared {
//            self.dataModel?.addMyData()
//            }
//        }
    }
}

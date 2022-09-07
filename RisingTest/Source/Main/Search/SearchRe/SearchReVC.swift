//
//  SearchReVC.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/09/02.
//

import Foundation
import UIKit
class SearchReVC: UIViewController{
    static let identifier = "SearchReVC"
    //통신 API
    var searchData : SearchReDataManager?
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewTop: NSLayoutConstraint!
    
    // 스티키 헤더
    var header: SearchReHeaderView?
    var wrapperHeight : CGFloat?
    var myCategoryImg :UIImage?
    var myTitle : String?
    //검색 데이터
    var mySearchText: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.showIndicator()
        self.searchData = SearchReDataManager(query: self.mySearchText!, reload: self)
        self.searchData?.addMyData()
        self.collectionView.register(UINib(nibName: BrandSuggestCell.identifier, bundle: nil), forCellWithReuseIdentifier: BrandSuggestCell.identifier)
        self.collectionView.register(UINib(nibName: SearchReHeaderView.identifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SearchReHeaderView.identifier)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.collectionViewLayout = createCompositionalLayout()
        navigationSettings()
        print(myTitle ?? "없음")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        if dataModel!.nowListCount == 0 {
//            self.dataModel?.addMyData()
//        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let headerHeight = self.header?.headerWrapper.frame.height{
            self.wrapperHeight = self.wrapperHeight ?? (headerHeight + self.topbarHeight)
        }
        
        print("navi Height",self.topbarHeight)
    }
}

// MARK: -- 컬렉션 뷰 설정
extension SearchReVC: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let idx = indexPath.item
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BrandSuggestCell.identifier, for: indexPath) as! BrandSuggestCell
        //MARK: -- 서버 연결 필요
        cell.setData((self.searchData?.data[indexPath.item])!)
        cell.titleImgView.image = self.searchData?.dataImgView[indexPath.item].image ?? UIImage(named: "onboard1")
        //cell.setData(searchData)
        if(idx + 6 == self.searchData?.nowListCount){self.searchData?.addMyData()}
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nextVC = UIStoryboard(name: "HomeStoryboard", bundle: nil).instantiateViewController(withIdentifier: ItemVC.identifer) as! ItemVC
        //MARK: -- 서버 열리면 수정!!
        nextVC.myPostIdx = self.searchData?.data[indexPath.item].postIdx ?? -1
        //nextVC.myPostIdx = 12
        navigationController?.pushViewController(nextVC, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //MARK: -- 서버연결 필요
        //return 30
        return self.searchData?.data.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SearchReHeaderView.identifier, for: indexPath) as! SearchReHeaderView
        self.header = header
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
extension SearchReVC{
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
extension SearchReVC{
    func navigationSettings(){
        let searchBar: UISearchBar = {
           let sb = UISearchBar()
           sb.placeholder = "검색어를 입력해주세요"
           let emptyImage = UIImage()
           sb.setImage(emptyImage, for: .search, state: .normal)
           return sb
        }()
        searchBar.delegate = self
        searchBar.text = mySearchText ?? ""
        self.navigationItem.titleView = searchBar
        self.navigationItem.leftBarButtonItem = {
            let item = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(self.closeView))
            item.image = UIImage(systemName: "chevron.left")
            item.tintColor = .black
            return item
        }()
        self.view.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = {
            let item = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(searchView))
            item.image = UIImage(systemName: "house")
            item.tintColor = .black
            return item
        }()
    }
    @objc func closeView(){
        _ = self.navigationController?.popViewController(animated: true)
    }
    @objc func searchView(){
        self.navigationController?.popToRootViewController(animated: true)
    }
    @objc func shareView(){
        print("공유 구현 해야한다.")
    }
}
// 검색 창 재검색 가능
extension SearchReVC: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchAction(text: searchBar.text!)
    }
    func searchAction(text: String){
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: SearchReVC.identifier) as! SearchReVC
        vc.mySearchText = text
        Dummy.RECTENT_SEARCH.append(text)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
//MARK: -- Categoty 무한 스크롤 데이터 얻기
extension SearchReVC:ReloadProtocol{
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
//        if self.dataModel?.data.count == 0{
//            didFailedGetResult(message: "알 수 없는 오류")
//        }
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

//
//  ItemVC.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/24.
//

import Foundation
import UIKit
import PanModal
import TagListView
class ItemVC: UIViewController{
    @IBOutlet weak var tagListView: TagListView!
    @IBOutlet weak var itemImgSliderView: ItemImgSlider!
    let dummyImgData: [String] = ["https://images.unsplash.com/photo-1661758239207-0410635ad099?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80","https://res.cloudinary.com/roundglass/image/upload/w_1104,h_736,c_fill/q_auto:best,f_auto/v1632484088/rg/collective/media/common-kingfisher-dhritiman-mukherjee-1632484087720.jpg","https://images.unsplash.com/photo-1661758239207-0410635ad099?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80"
    ]
    let dummyData: ItemResult = ItemResult(postIdx: 3, price: 20000, payStatus: false, postTitle: "맥북 에어 m2 미개봉", postingTime: "4일 전", viewNum: 11, likeNum: 3, chatNum: 0, prodStatus: "중고상품", quantity: 1, deliveryFee: "N", exchange: "불가", postContent: "어제 배송 받은 x맥북 에어 M2 스타라이트(미개봉) 8코어 CPU 8코어 GPU 256GB 팝니다. 용량 더 큰걸로 사고 싶어서 싸게 내놓습니다. 이번주 안에 안팔리면 그냥 사용한 예정 정가 169만원", sellingStatus: "판매중", zzimStatus: true)
    static let identifer = "ItemVC"
    @IBOutlet weak var shopCollectionView: UICollectionView!
    @IBOutlet weak var shopCollectionHeight: NSLayoutConstraint!
    @IBOutlet weak var adCollectionView: UICollectionView!
    @IBOutlet weak var adCollectionHeight: NSLayoutConstraint!
    
    lazy var itemDataManager = ItemDataManager()
    lazy var itemShopManager = ItemShopManager()
    lazy var itemImgDataManager = ItemImgDataManager()
    lazy var hashTagDataManager = HashTagDataManager()
    lazy var adShopManager = AdShopManager(data:AdShopData.shared.adData)
    var myItemData : ItemResult?
    var myPostIdx : Int = -1
    var isSuccessCount = 0 {
        willSet{
            if newValue == 2{
                self.dismissIndicator()
            }
        }
    }
    @IBOutlet weak var tagListHeight: NSLayoutConstraint!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var safePayView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationInfoLabel: UILabel!
    @IBOutlet weak var uploadDateLabel: UILabel!
    @IBOutlet weak var viewNumBtn: UIButton!
    @IBOutlet weak var likeNumBtn: UIButton!
    @IBOutlet weak var chatNumBtn: UIButton!
    @IBOutlet weak var productStatusLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var deliveryFeeLabel: UILabel!
    @IBOutlet weak var exchangeLabel: UILabel!
    @IBOutlet weak var postContent: UITextView!
    @IBOutlet weak var zzimBtn: UIButton!
    var itemShopData : [RecommendResult]?
    override func viewDidLoad() {
        super.viewDidLoad()
        shopCollectionSettings()
        adCollectionSettings()
        self.navigationSettings()
        print("myPostIdx",self.myPostIdx)
        //MARK: -- API 수정
        self.showIndicator()
        self.itemDataManager.getItem(postIdx: self.myPostIdx,delegate: self)
        self.itemImgDataManager.getItem(postIdx: self.myPostIdx, delegate: self)
        self.hashTagDataManager.getItem(self.myPostIdx, delegate: self)
//        self.didSuccessGetItem(dummyData)
//        self.didSuccessGetItemImg(dummyImgData)
        tagListView.textFont = .systemFont(ofSize: 14, weight: .semibold)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.setZzimStyle()
    }
    override func viewDidAppear(_ animated: Bool) {
        let height = self.adCollectionView.collectionViewLayout.collectionViewContentSize.height
        let shopHeight = self.shopCollectionView.collectionViewLayout.collectionViewContentSize.height
        self.adCollectionHeight.constant = height
        self.shopCollectionHeight.constant = shopHeight
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.itemShopData = nil
        
    }
    @IBAction func talkBtnAction(_ sender: UIButton) {
    }
    @IBAction func safePayBtnAction(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: SafePayModalVC.identifier) as! SafePayModalVC
        vc.complation = { isDelivery in
            let vc = self.storyboard?.instantiateViewController(withIdentifier: PayVC.identifier) as! PayVC
            vc.myPrice = self.myItemData!.price
            vc.imgURL = self.itemImgSliderView!.data[0]
            vc.myTitle = self.myItemData!.postTitle
            vc.isDelivery = isDelivery
            self.navigationController?.pushViewController(vc, animated: true)
        }
        presentPanModal(vc)
    }
    @IBAction func zzimBtnAction(_ sender: UIButton) {
        myItemData!.zzimStatus.toggle()
        self.setZzimStyle()
        self.presentBottomAlert(message: self.myItemData!.zzimStatus ? "찜 목록에 추가되었어요!" : "찜 해제가 완료되었습니다.")
    }
    func setZzimStyle(){
        if myItemData?.zzimStatus == true{
            self.zzimBtn.tintColor = .systemPink
            let image = UIImage(systemName: "heart.fill",withConfiguration: UIImage.SymbolConfiguration(pointSize: 18,weight: .bold,scale: .large))
            self.zzimBtn.setImage(image, for: .normal)
            
        }else{
            self.zzimBtn.tintColor = .lightGray
            let image = UIImage(systemName: "heart",withConfiguration: UIImage.SymbolConfiguration(pointSize: 18,weight: .bold,scale: .large))
            self.zzimBtn.setImage(image, for: .normal)
        }
         
        
    }
}
//MARK: -- 해시태그 가져오기
extension ItemVC: HashTagDelegate{
    func didSuccessGetItem(_ data: [HashTagResult]){
        data.forEach { result in
            self.tagListView.addTag("#\(result.hashTagName)")
            tagListHeight.constant = self.tagListView.intrinsicContentSize.height
        }
    }
    func failedToRequest(message: String){
        self.presentAlert(title: message)
    }
}
//MARK: -- 컬렉션 뷰 설정
extension ItemVC{
    //MARK: -- 이 상점의 상품 콜렉션
    func shopCollectionSettings(){
        self.itemShopManager.myVC = self
        self.itemShopManager.heightMethod = { height in self.shopCollectionHeight.constant = height*2}
        self.shopCollectionView.register(UINib(nibName: ItemShopCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: ItemShopCollectionViewCell.identifier)
        self.shopCollectionView.delegate = itemShopManager
        self.shopCollectionView.dataSource = itemShopManager
        self.shopCollectionView.collectionViewLayout = ItemShopManager.createCompositionalLayout()
        self.shopCollectionView.register(UINib(nibName: ItemHeaderCollectionReusableView.identifier, bundle: nil), forSupplementaryViewOfKind: "myHeader", withReuseIdentifier: ItemHeaderCollectionReusableView.identifier)
    }
    //MARK: -- 파워쇼핑, 이 상품과 비슷해요 컬렉션
    func adCollectionSettings(){
        self.adShopManager.myVC = self
        self.adCollectionView.register(UINib(nibName: ItemShopCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: ItemShopCollectionViewCell.identifier)
        self.adCollectionView.register(UINib(nibName: AdShopCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: AdShopCollectionViewCell.identifier)
        self.adCollectionView.register(UINib(nibName: ItemHeaderCollectionReusableView.identifier, bundle: nil), forSupplementaryViewOfKind: "header", withReuseIdentifier: ItemHeaderCollectionReusableView.identifier)
        self.adCollectionView.delegate = adShopManager
        self.adCollectionView.dataSource = adShopManager
        self.adCollectionView.collectionViewLayout = AdShopManager.createCompositionalLayout()
    }
}
//MARK: -- Navigation 설정
extension ItemVC{
    func navigationSettings(){
        self.navigationItem.leftBarButtonItem = {
            let item = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(self.closeView))
            item.image = UIImage(systemName: "chevron.left")
            item.tintColor = .black
            return item
        }()
        self.view.backgroundColor = .white
        self.navigationItem.rightBarButtonItems = [{
            let item = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(shareView))
            item.image = UIImage(systemName: "square.and.arrow.up")
            item.tintColor = .black
            return item
        }(),{
            let item = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(searchView))
            item.image = UIImage(systemName: "magnifyingglass")
            item.tintColor = .black
            return item
        }()]
    }
    @objc func closeView(){
        self.itemImgSliderView = nil
        _ = self.navigationController?.popViewController(animated: true)
    }
    @objc func searchView(){
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: SearchVC.identifer) as! SearchVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func shareView(){
        print("공유 구현 해야한다.")
    }
}
//MARK: -- API 통신 델리게이트
extension ItemVC{
    func didSuccessGetItem(_ result: ItemResult){
        print(#function)
        self.myItemData = result
        self.priceLabel.text = Variable.getMoneyFormat(result.price)
        self.safePayView.isHidden = !(result.payStatus)
        self.titleLabel.text = result.postTitle
        if let region = result.tradeRegion{
            self.locationInfoLabel.text = region == "" ?  "지역정보 없음" : region
        }else{
            self.locationInfoLabel.text = "지역정보 없음"
        }
        self.uploadDateLabel.text = result.postingTime
        self.viewNumBtn.setTitle(String(result.viewNum), for: .normal)
        self.viewNumBtn.titleLabel?.text = String(result.viewNum)
        self.chatNumBtn.titleLabel?.text = String(result.chatNum)
        self.likeNumBtn.titleLabel?.text = String(result.likeNum)
        self.productStatusLabel.text = result.prodStatus
        self.quantityLabel.text = "총 \(result.quantity)개"
        self.deliveryFeeLabel.text = result.deliveryFee == "N" ? "배송비별도" : "배송비 문의"
        self.exchangeLabel.text = result.exchange
        self.postContent.text = result.postContent
        self.isSuccessCount += 1
        self.setZzimStyle()
    }
    func failedGetItem(message: String){
        self.presentAlert(title: message,message: "나중에 다시 시도하세요.") { action in
            self.navigationController?.popViewController(animated: true)
        }
    }
    func didSuccessGetItemImg(_ resultList: [ItemImgResult]){
        let data : [String] = resultList.map { (result:ItemImgResult) -> String in
            return result.postImg_url
        }
        itemImgSliderView.setData(data: data)
        self.isSuccessCount += 1
    }
    //데이터 임시
    func didSuccessGetItemImg(_ resultList: [String]){
        itemImgSliderView.setData(data: resultList)
        self.isSuccessCount += 1
    }
}

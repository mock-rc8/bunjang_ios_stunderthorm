//
//  RegiVC.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/23.
//

import UIKit
import TweeTextField
extension Notification.Name{
    static let Category = Notification.Name("Category")
}
class RegiVC: UIViewController{
    static let identifer = "RegiVC"
    @IBOutlet weak var optionTextView: UITextView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var exchangeLabel: UILabel!
    @IBOutlet weak var deliveryFeeBtn: UIButton!
    @IBOutlet weak var categoryField: TweeAttributedTextField!
    @IBOutlet weak var tagField: TweeAttributedTextField!
    @IBOutlet weak var itemTitleField: TweeAttributedTextField!
    @IBOutlet weak var priceTextField: TweeAttributedTextField!
    @IBOutlet weak var safePayCheckMark: UIImageView!
    @IBOutlet weak var safePayWrapper: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var textField: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var optionBtn: UIButton!
    lazy var collectionManager = RegisterImageScrollManager(data:[])
    lazy var tempTitle = RegisterRequest(postImg_url: ["https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTl-FrXpdUtIR5iCeVZCp4dGIh3uiENuo9OHg&usqp=CAU", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQKtQope-BdIw_CFcgjw_MWsYKJC4BchgE7ow&usqp=CAU"], tradeRegion: "시흥시 신천동", postTitle: "test", postContent: "testContent", categoryIdx: 1, hashTagName: ["삼성전자", "삼성"], price: 100, deliveryFee: "N", quantity: 1, prodStatus: "중고상품", exchange: "불가", payStatus: "N")
    lazy var data = RegisterData()
    lazy var dataManager: RegisterDataManager = RegisterDataManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        self.scrollView.showsVerticalScrollIndicator = false
        self.dismissKeyboardWhenTappedAround()
        self.categoryField.isUserInteractionEnabled = false
        self.tagField.isUserInteractionEnabled = false
        self.priceTextField.delegate = self
        collectionViewSettings()
        textFieldSettings()
        categorySettings()
        self.style()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationSettings()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
    }
    func style(){
        self.safePayWrapper.layer.borderWidth = 1
        self.safePayWrapper.layer.borderColor = UIColor.darkGray.cgColor
        self.safePayWrapper.layer.cornerRadius = 5
        self.optionBtn.layer.borderWidth = 1
        self.optionBtn.layer.borderColor = UIColor.lightGray.cgColor
        self.optionBtn.layer.cornerRadius = 5
    }
    func collectionViewSettings(){
        self.collectionView.delegate = collectionManager
        self.collectionView.dataSource = collectionManager
        self.collectionView.register(UINib(nibName: RegisterImageScrollCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: RegisterImageScrollCollectionViewCell.identifier)
        self.collectionView.register(UINib(nibName: RegiCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: RegiCollectionViewCell.identifier)
        self.collectionView.collectionViewLayout = RegisterImageScrollManager.createSliderCompositionalLayout(self.collectionView.frame.height)
    }
    func textFieldSettings(){
        textField.delegate = self
        setEmptyText(textField)
    }
}
//MARK: -- 카테고리 세팅
extension RegiVC{
    func categorySettings(){
        NotificationCenter.default.addObserver(self, selector: #selector(getCategory(notification:)), name: Notification.Name.Category, object: nil)
    }
    @objc func getCategory(notification: Notification?){
        var viewData = notification?.userInfo?["ViewData"] as! [String]
        let serverData = notification?.userInfo?["ServerData"] as! Int
        viewData.removeFirst()
        categoryField.text = viewData.joined(separator: " - ")
        self.data.categoryIdx = serverData
    }
    @IBAction func categoryBtnAction(_ sender: UIButton) {
        let vc = UIStoryboard(name: "RegisterStoryboard", bundle: nil).instantiateViewController(withIdentifier: RegisterCategoryVC.identifier) as! RegisterCategoryVC
        vc.setCategoryData()
        vc.myRootVC = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
//MARK: -- 네비게이션 세팅
extension RegiVC{
    func navigationSettings(){
        self.navigationItem.leftBarButtonItem = {
            let item = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(self.closeView))
            item.image = UIImage(systemName: "chevron.left")
            item.tintColor = .black
            return item
        }()
        self.view.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItem = {
            let item = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(closeView))
            item.tintColor = .black
            item.customView = {
                let button = UIButton()
                button.setTitle(Variable.USER_LOCATION, for: .normal)
                button.titleLabel?.font = UIFont(name: "System", size: 14)
                button.titleLabel!.font = UIFont.boldSystemFont(ofSize: 14)
                button.setTitleColor(.gray, for: .normal)
                button.setUnderline()
                button.tintColor = .black
                button.addTarget(self, action: #selector(segueLocationView), for: .touchDown)
                return button
            }()
            return item
        }()
    }
    @objc func closeView() {
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromBottom
        navigationController?.view.layer.add(transition, forKey: nil)
        _ = navigationController?.popViewController(animated: false)
    }
    @objc func segueLocationView(){
        let vc = UIStoryboard(name: "SettingStoryboard", bundle: nil).instantiateViewController(withIdentifier: LocationSetVC.identifier) as! LocationSetVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
//MARK: -- 옵션 모달 설정
extension RegiVC{
    @IBAction func choiceBtnAction(_ sender: UIButton) {
        let vc = UIStoryboard(name: "RegisterStoryboard", bundle: nil).instantiateViewController(withIdentifier: RegisterOptionModalVC.identifier) as! RegisterOptionModalVC
        vc.completeAction = {
            (status: ProdStatus, exchangable: Bool,itemCount: Int) in
            self.data.prodStatus = status
            self.data.exchange = exchangable
            self.data.quantity = itemCount
            self.countLabel.text = "\(itemCount) 개"
            self.statusLabel.text = status.rawValue
            self.exchangeLabel.text = exchangable == true ? "가능" : "불가"
        }
        presentPanModal(vc)
    }
}
//MARK: -- 등록 버튼 액션 모음
extension RegiVC{
    @IBAction func registerBtnAction(_ sender: UIButton) {
        self.data.tradeRegion = Variable.USER_LOCATION
        self.data.postTitle = self.itemTitleField.text!
        self.data.postContent = self.textField.text!
        let rawPrice = self.priceTextField.text!.replacingOccurrences(of: "₩ ", with: "")
        self.data.price = Int(rawPrice) ?? -1
        if checkData(){
            let requestData = self.data.changeRequestData()
            dataManager.postSignIn(requestData, delegate: self)
        }
    }
    func checkData()->Bool{
        if self.data.postTitle == "" {
            self.presentAlert(title: "상품 제목을 입력하세요!!")
            return false
        }
        if self.data.categoryIdx == -1 {
            self.presentAlert(title: "카테고리를 선택하세요!!")
            return false
        }
        if self.data.price == -1 {
            self.presentAlert(title: "가격을 입력하세요!!")
        }
        if self.data.quantity <= 0 {
            self.presentAlert(title: "수량 오류입니다!!")
        }
        return true
    }
}
//MARK: -- 버튼 액션 모음
extension RegiVC{
    @IBAction func tabBtnAction(_ sender: UIButton) {
        let vc = UIStoryboard(name: "RegisterStoryboard", bundle: nil).instantiateViewController(withIdentifier: RegisterTagVC.identifier) as! RegisterTagVC
        vc.delegate = { myTags in
            var string = ""
            myTags.forEach { tag in
               let tagString = "#\(tag)"
                string = "\(string) \(tagString)"
            }
            self.tagField.text = string
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func deliveryBtnAction(_ sender: UIButton) {//배달 가능여부 데이터 설정
        let red = #colorLiteral(red: 0.846611917, green: 0.04588327557, blue: 0.09413331002, alpha: 1)
        if data.deliveryFee == false{
            self.deliveryFeeBtn.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            self.deliveryFeeBtn.tintColor = red
        }else{
            self.deliveryFeeBtn.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
            self.deliveryFeeBtn.tintColor = .gray
        }
        data.deliveryFee.toggle()
    }
    @IBAction func safePayBtnAction(_ sender: UIButton) {//안전페이 가능여부 데이터 설정
        if data.payStatus == .unsafe{
            let red = #colorLiteral(red: 0.846611917, green: 0.04588327557, blue: 0.09413331002, alpha: 1)
            self.safePayCheckMark.tintColor = red
            self.safePayWrapper.layer.borderColor = red.cgColor
            self.data.payStatus = .safe
        }else{
            self.safePayCheckMark.tintColor = .darkGray
            self.safePayWrapper.layer.borderColor = UIColor.darkGray.cgColor
            self.data.payStatus = .unsafe
        }
    }
    @objc func priceTextFieldTap(_ sender: Any){
        print("hello world!!")
    }
    func didSuccessRegister(_ result: RegisterResult) {
       
        
        self.presentAlert(title: "업로드에 성공했습니다!!") { action in
            NotificationCenter.default.removeObserver(self, name: Notification.Name.LogIn, object: nil)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func failedToRegister(message: String) {
        self.presentAlert(title: message)
    }
}

extension RegiVC: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.textColor == .placeholderText else { return }
        textView.textColor = .label
        textView.text = nil
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            setEmptyText(textView)
        }
    }
    func setEmptyText(_ textview: UITextView){
        textview.text = "여러 자의 상품 사진과 구입 연도, 브랜드, 사용감, 하자유부 등 구매자에게 필요한 정보를 꼭 포함해 주세요.\n문의를 줄이고 더 쉽게 판매할 수 있어요. (10자 이상)"
        textview.textColor = .placeholderText
    }
}
extension RegiVC: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField{
        case self.priceTextField:
            if textField.text!.count < 2{
                textField.text = "₩ "
            }
        default:break
        }
    }
    func textFieldDidChangeSelection(_ textField: UITextField) {
        switch textField{
        case self.priceTextField:
            if textField.text!.count < 2{
                textField.text = "₩ "
            }
        default:break
        }
    }
}

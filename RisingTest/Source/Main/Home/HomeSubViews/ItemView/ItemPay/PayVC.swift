//
//  PayVC.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/30.
//

import UIKit
import Kingfisher
class PayVC: UIViewController{
    static let identifier = "PayVC"
    @IBOutlet weak var itemImg: UIImageView!
    @IBOutlet weak var payTypeLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
    @IBOutlet weak var itemTitleLabel: UILabel!
    @IBOutlet weak var myLocationBtn: UIButton!
    @IBOutlet weak var safeTypeBtn: UIButton!
    @IBOutlet weak var myLocationTextField: UITextField!
    @IBOutlet weak var otherTypeBtn: UIButton!
    @IBOutlet weak var payToggleImg: UIImageView!
    @IBOutlet weak var safePayCircle: UIImageView!
    @IBOutlet weak var otherPayCircle: UIImageView!
    @IBOutlet weak var safePayLabel: UILabel!
    @IBOutlet weak var otherPayLabel: UILabel!
    @IBOutlet weak var choicePayTypeBtn: UIButton!
    @IBOutlet weak var payTypeTextField: UITextField!
    @IBOutlet weak var totalPayPriceLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var deliveryRequestTextField: UITextField!
    var isDelivery = true
    var isPayAgree = false
    var myTitle = ""
    var imgURL = ""
    var myPrice = 0
    var payType : PayType = .none{
        willSet{
            switch newValue{
            case .safe:
                self.isSafeTyoe = true
            default:
                self.isSafeTyoe = false
            }
            payTypeStyle()
        }
    }
    var isSafeTyoe = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initSettings()
        self.setPrice()
        self.itemImg.kf.setImage(with: URL(string: self.imgURL))
        self.itemTitleLabel.text =  self.myTitle
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeFn))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(), style: .plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItem?.tintColor = .black
    }
    public func setPrice(){
        let priceString = Variable.getMoneyFormat(self.myPrice)
        self.itemPriceLabel.text = priceString
        self.productPriceLabel.text = priceString
        self.totalPayPriceLabel.text = priceString
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.myLocationTextField.text = Variable.USER_LOCATION
        payTypeStyle()
    }
    @objc func closeFn(){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func myLocationBtnAction(_ sender: UIButton) {
        let vc = UIStoryboard(name: "SettingStoryboard", bundle: nil).instantiateViewController(withIdentifier: LocationSetVC.identifier) as! LocationSetVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    //결제 하기 버튼
    @IBAction func payBtnAction(_ sender: UIButton) {
        if payType == .none{
            self.presentAlert(title: "결제 수단을 선택하세요")
            return
        }
        if isPayAgree == false{
            self.presentAlert(title: "정보 이용약관에 동의해주세요.")
            return
        }
        self.navigationController?.popToRootViewController(animated: true)
    }
    // 다른 결제 수단 버튼
    @IBAction func otherPayBtnAction(_ sender: UIButton) {
        if self.isSafeTyoe == true{
            self.presentBottomAlert(message: "다른 결제수단을 선택해주세요.")
        }else{
        let vc = self.storyboard?.instantiateViewController(withIdentifier: OtherPayModalVC.identifier) as! OtherPayModalVC
        vc.payTextField = self.payTypeTextField
        vc.completion = { thisType in
            self.payType = thisType
        }
        presentPanModal(vc)
        }
    }
    @IBAction func requestBntAction(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: PayRequestModalVC.identifier) as! PayRequestModalVC
        vc.myTextField = self.deliveryRequestTextField
        presentPanModal(vc)
    }
    
}

//MARK: -- 처음 생성 세팅
extension PayVC{
    func initSettings(){
        payTypeLabel.text = isDelivery ? "택배거래,안전결제로 \n구매합니다." : "직거래, 안전결제로 \n구매합니다."
        self.myLocationTextField.text = Variable.USER_LOCATION
        self.payTypeStyle()
    }
}
//MARK: -- 서비스 이용동의
extension PayVC{
    @IBAction func agreeBtnAction(_ sender: UIButton) {
        isPayAgree.toggle()
        payAgreeStyle()
    }
    func payAgreeStyle(){
        let red = #colorLiteral(red: 0.846611917, green: 0.04588327557, blue: 0.09413331002, alpha: 1)
        if isPayAgree{
            payToggleImg.image = UIImage(systemName: "circle.fill")
            payToggleImg.tintColor = red
        }else{
            payToggleImg.image = UIImage(systemName: "circle")
            payToggleImg.tintColor = .gray
        }
    }
}
//MARK: -- 결제 수단
extension PayVC{
    @IBAction func patTypeBtnAction(_ sender: UIButton) {
        switch sender{
        case self.safeTypeBtn:
            self.isSafeTyoe = true
            self.payType = .safe
        case self.otherTypeBtn:
            self.isSafeTyoe = false
            self.payType = .none
        default: break
        }
    }
    func payTypeStyle(){
        let red = #colorLiteral(red: 0.846611917, green: 0.04588327557, blue: 0.09413331002, alpha: 1)
        if isSafeTyoe{
            self.safePayCircle.image = UIImage(systemName: "circle.fill")
            self.safePayCircle.tintColor = red
            self.otherPayCircle.image = UIImage(systemName: "circle")
            self.otherPayCircle.tintColor = .gray
            self.otherPayLabel.textColor = .gray
            self.safePayLabel.textColor = .black
        }else{
            self.safePayCircle.image = UIImage(systemName: "circle")
            self.safePayCircle.tintColor = .gray
            self.otherPayCircle.image = UIImage(systemName: "circle.fill")
            self.otherPayCircle.tintColor = red
            self.otherPayLabel.textColor = .black
            self.safePayLabel.textColor = .gray
        }
    }
}
enum PayType:String{
    case safe = "안전결제"
    case credit = "신용 / 체크카드등록"
    case kakaoPay = "카카오페이"
    case toss = "토스"
    case account = "간편계좌결제"
    case phone = "휴대폰결제"
    case none = "결제 수단을 등록해주세요."
}

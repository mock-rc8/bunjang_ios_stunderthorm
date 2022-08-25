//
//  RegiVC.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/23.
//

import UIKit
import TweeTextField
class RegiVC: UIViewController{
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
    lazy var collectionManager = RegisterImageScrollManager(data:["안녕하세요","잘 가세요","","","","","",""])
    lazy var tempTitle = RegisterRequest(postImg_url: ["https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTl-FrXpdUtIR5iCeVZCp4dGIh3uiENuo9OHg&usqp=CAU", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQKtQope-BdIw_CFcgjw_MWsYKJC4BchgE7ow&usqp=CAU"], tradeRegion: "시흥시 신천동", postTitle: "test", postContent: "testContent", categoryIdx: 1, hashTagName: ["삼성전자", "삼성"], price: 100, deliveryFee: "N", quantity: 1, prodStatus: "중고상품", exchange: "불가", payStatus: "N")
    lazy var data = RegisterData()
    lazy var dataManager: RegisterDataManager = RegisterDataManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dismissKeyboardWhenTappedAround()
        self.categoryField.isUserInteractionEnabled = false
        self.tagField.isUserInteractionEnabled = false
        self.priceTextField.delegate = self
        collectionViewSettings()
        textFieldSettings()
        self.style()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
    }
    func style(){
        self.safePayWrapper.layer.borderWidth = 1
        self.safePayWrapper.layer.borderColor = UIColor.darkGray.cgColor
        self.safePayWrapper.layer.cornerRadius = 5
    }
    func collectionViewSettings(){
        self.collectionView.delegate = collectionManager
        self.collectionView.dataSource = collectionManager
        self.collectionView.register(UINib(nibName: RegisterImageScrollCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: RegisterImageScrollCollectionViewCell.identifier)
        self.collectionView.collectionViewLayout = RegisterImageScrollManager.createSliderCompositionalLayout(self.collectionView.frame.height)
    }
    func textFieldSettings(){
        textField.delegate = self
        setEmptyText(textField)
    }
}
//MARK: -- 버튼 액션 모음
extension RegiVC{
    @IBAction func categoryBtnAction(_ sender: UIButton) {
        let vc = UIStoryboard(name: "RegisterStoryboard", bundle: nil).instantiateViewController(withIdentifier: RegisterCategoryVC.identifier) as! RegisterCategoryVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func tabBtnAction(_ sender: UIButton) {
        let vc = UIStoryboard(name: "RegisterStoryboard", bundle: nil).instantiateViewController(withIdentifier: RegisterTagVC.identifier) as! RegisterTagVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func choiceBtnAction(_ sender: UIButton) {
        let vc = UIStoryboard(name: "RegisterStoryboard", bundle: nil).instantiateViewController(withIdentifier: RegisterOptionModalVC.identifier) as! RegisterOptionModalVC
        presentPanModal(vc)
    }
    @IBAction func deliveryBtnAction(_ sender: UIButton) {
        if data.deliveryFee == false{
            self.deliveryFeeBtn.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            self.deliveryFeeBtn.tintColor = .red
        }else{
            self.deliveryFeeBtn.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
            self.deliveryFeeBtn.tintColor = .gray
        }
        data.deliveryFee.toggle()
    }
    @IBAction func safePayBtnAction(_ sender: UIButton) {
        if data.payStatus == .unsafe{
            self.safePayCheckMark.tintColor = .red
            self.safePayWrapper.layer.borderColor = UIColor.red.cgColor
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
    @IBAction func registerBtnAction(_ sender: UIButton) {
        dataManager.postSignIn(self.tempTitle, delegate: self)
    }
    func didSuccessSignIn(_ result: RegisterResult) {
//       self.presentAlert(title: "로그인에 성공하였습니다", message: String(result.postIdx))
    }
    
    func failedToRequest(message: String) {
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
        textview.text = "텍스트 입력"
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

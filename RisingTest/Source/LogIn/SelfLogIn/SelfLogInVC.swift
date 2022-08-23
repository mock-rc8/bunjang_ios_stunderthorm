//
//  SelfLogInVC.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/21.
//

import UIKit
import TweeTextField
class SelfLogInVC:UIViewController,UITextFieldDelegate{
    static let identifier = "SelfLogInVC"
    @IBOutlet weak var logInSlider: SelfLogInSlider!
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var carriorTextField: TweeAttributedTextField!
    @IBOutlet weak var birthTextField: TweeAttributedTextField!
    @IBOutlet weak var phoneNumberTextField: TweeAttributedTextField!
    @IBOutlet weak var nameTextField: TweeAttributedTextField!
    @IBOutlet weak var sexTextField: TweeAttributedTextField!
    @IBOutlet weak var stackView: UIStackView!
    var sliderIdx = 0
    var suvViewIdx = 0
    var selectedCarriorViewIdx: Int? = nil
    var allTextField: [UITextField]?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.setHidesBackButton(true, animated: true)
        let barBtn = UIBarButtonItem(image:UIImage(systemName: "chevron.left")!, style: .plain, target: self, action: #selector(backBtn))
        barBtn.tintColor = .black
        self.navigationItem.setLeftBarButton(barBtn, animated: true)
        self.confirmBtn.layer.cornerRadius = 10
        self.birthTextField.minimumPlaceholderFontSize = 1
        self.confirmBtn.isEnabled = false
        self.setConfirmStyle()
        self.allTextField = [phoneNumberTextField,nameTextField,birthTextField,carriorTextField,sexTextField]
        self.allTextField!.forEach { textField in
            textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        }
        self.stackView.subviews.forEach { view in
            view.isHidden = true
        }
        [self.nameTextField,self.sexTextField,self.phoneNumberTextField].forEach{$0?.delegate = self}
        self.suvViewIdx = self.stackView.subviews.count-1
        self.stackView.subviews[suvViewIdx].isHidden = false
        self.dismissKeyboardWhenTappedAround()
    }
    @objc func backBtn(){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func carriorBtn(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: CarriorModalVC.identifier) as! CarriorModalVC
        vc.parentView = self
        presentPanModal(vc)
    }
    @IBAction func conFirmBtn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: AgreeModalVC.identifier) as! AgreeModalVC
        let requestData = SignInRequest(name: nameTextField.text!, telephone: Int(phoneNumberTextField.text!)!, birth: Int(birthTextField.text!)!)
        vc.requestData = requestData
        presentPanModal(vc)
    }
    func setCarriorName(_ str:String){
        self.carriorTextField.text = str
    }
    //logInSlider.callNextItem() -> 이미지 슬라이더 메서드
    @objc func textFieldDidChange(_ sender: UITextField){
        switch sender{
        case self.nameTextField: break
        case self.birthTextField:
            if let textCount =  self.birthTextField.text?.trim?.count{
                if textCount >= 6 {
                    self.birthTextField.resignFirstResponder()
                    self.sexTextField.becomeFirstResponder()
                }
            }
        case self.phoneNumberTextField:
            if let textCount =  self.phoneNumberTextField.text?.trim?.count{
                if textCount >= 11 {
                    self.logInSlider.callNextItem()
                    self.phoneNumberTextField.resignFirstResponder()
                }
            }
        case self.sexTextField:
            nextFieldShow()
        default: break
        }
        self.confirmBtnShow()
    }
    func confirmBtnShow(){
        let isAllTextFilled = !(self.allTextField?.contains{ return !$0.text!.trim!.isExists})!
        if isAllTextFilled == true{
            self.confirmBtn.isEnabled = true
            setConfirmStyle()
        }else{
            self.confirmBtn.isEnabled = false
            setConfirmStyle()
        }
    }
    func setConfirmStyle(){
        if self.confirmBtn.isEnabled == false{
            let uiColor:UIColor = #colorLiteral(red: 1, green: 0.1764705882, blue: 0.3333333333, alpha: 0.48)
            self.confirmBtn.backgroundColor = uiColor
        }else{
            self.confirmBtn.backgroundColor = #colorLiteral(red: 1, green: 0.1764705882, blue: 0.3333333333, alpha: 1)
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(#function)
        nextFieldShow()
        return true
    }
    func nextFieldShow(){
        if self.suvViewIdx > 0 {
            self.suvViewIdx = self.suvViewIdx - 1
            self.logInSlider.callNextItem()
            DispatchQueue.main.async {
                UIView.transition(with: self.stackView.subviews[self.suvViewIdx], duration: 0.2) {
                    self.stackView.subviews[self.suvViewIdx].isHidden = false
                }
            }
            print(self.suvViewIdx)
        }
    }
}


//MARK: -- 인포 슬라이더
class SelfLogInSlider: UIView,SliderDelegate{
    var data: [String] = ["이름을\n입력해주세요","생년월일을\n입력해주세요","통신사를\n선택해주세요","휴대폰번호를\n입력해주세요","입력된 정보를 \n확인해주세요"]
    var selfLogInSliderManager: SelfLogInSliderManager?
    var sliderCollection: UICollectionView!
    var sliderIdx = 0
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print("SelfLogInSlider!!")
        selfLogInSliderManager = SelfLogInSliderManager(data: self.data)
        self.sliderCollection = UICollectionView(frame: .zero, collectionViewLayout: SelfLogInSliderManager.createSliderCompositionalLayout())
        self.sliderCollection.register(UINib(nibName: SelfLogInCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: SelfLogInCollectionViewCell.identifier)
        self.sliderCollection.dataSource = selfLogInSliderManager
        self.sliderCollection.delegate = selfLogInSliderManager
        self.sliderCollection.collectionViewLayout = SelfLogInSliderManager.createSliderCompositionalLayout()
        // 스크롤 안되고 페이징 기법 쓰기
        self.sliderCollection.isScrollEnabled = false
        self.sliderCollection.isPagingEnabled = true
        self.layout()
        
    }
    private func layout(){
        self.sliderCollection.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(sliderCollection)
        NSLayoutConstraint.activate([
            self.sliderCollection.topAnchor.constraint(equalTo: self.topAnchor),
            self.sliderCollection.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.sliderCollection.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.sliderCollection.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    func setData(data:[String]){
        self.data = data
    }
    func numberOfPages(count: Int){
    }
    func currentPage(index: Int){
    }
    func callNextItem(){
        self.sliderIdx = self.data.count - 1 == self.sliderIdx ? self.sliderIdx :  (self.sliderIdx + 1)
        self.sliderCollection.scrollToItem(at: NSIndexPath(item: self.sliderIdx, section: 0) as IndexPath, at: .top, animated: true)
    }
}


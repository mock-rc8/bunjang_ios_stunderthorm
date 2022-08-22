//
//  SelfLogInVC.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/21.
//

import UIKit
import TweeTextField
class SelfLogInVC:UIViewController{
    static let identifier = "SelfLogInVC"
    @IBOutlet weak var logInSlider: SelfLogInSlider!
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var carriorTextField: TweeAttributedTextField!
    @IBOutlet weak var birthTextField: TweeAttributedTextField!
    var sliderIdx = 0
    var selectedCarriorViewIdx: Int? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        //self.navigationController?.title = "안녕하세요!!"
        self.navigationItem.setHidesBackButton(true, animated: true)
        let barBtn = UIBarButtonItem(image:UIImage(systemName: "chevron.left")!, style: .plain, target: self, action: #selector(backBtn))
        barBtn.tintColor = .black
        self.navigationItem.setLeftBarButton(barBtn, animated: true)
        self.confirmBtn.layer.cornerRadius = 10
        self.birthTextField.minimumPlaceholderFontSize = 1
    }
    @objc func backBtn(){
        print("hello world")
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func carriorBtn(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: CarriorModalVC.identifier) as! CarriorModalVC
        vc.parentView = self
        presentPanModal(vc)
    }
    @IBAction func conFirmBtn(_ sender: Any) {
        
    }
    func setCarriorName(_ str:String){
        self.carriorTextField.text = str
    }
    //logInSlider.callNextItem() -> 이미지 슬라이더 메서드
}
//MARK: -- 인포 슬라이더
class SelfLogInSlider: UIView,SliderDelegate{
    var data: [String] = ["이름을 입력해주세요","생년월일을 입력해주세요","통신사를 선택해주세요","휴대폰번호를 입력해주세요","입력된 정보를 확인해주세요"]
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
        self.sliderCollection.scrollToItem(at: NSIndexPath(item: self.sliderIdx, section: 0) as IndexPath, at: .top, animated: true)
            self.sliderIdx = (self.sliderIdx + 1) % self.data.count
    }
}


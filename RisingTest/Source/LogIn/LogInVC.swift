//
//  LogInVC.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/21.
//

import UIKit

class LogInVC: UIViewController{
    @IBOutlet weak var kakaoLoginBtn: LogInBtn!
    @IBOutlet weak var appleLoginBtn: LogInBtn!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        kakaoLoginBtn.backgroundColor = .yellow
        kakaoLoginBtn.layer.borderColor = UIColor(white: 1, alpha: 1).cgColor
        appleLoginBtn.layer.borderColor = UIColor.black.cgColor
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    @IBAction func otherLoginAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: LogInModal.identifier) as! LogInModal
        vc.myParent = self
        vc.completionAction = {
            let vc = UIStoryboard(name: "SelfLogInStoryboard", bundle: nil).instantiateViewController(withIdentifier: SelfLogInVC.identifier) as! SelfLogInVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
        presentPanModal(vc)
    }
    @IBAction func kakaoLoginAction(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
            let vc = UIStoryboard(name: "SelfLogInStoryboard", bundle: nil).instantiateViewController(withIdentifier: SelfLogInVC.identifier) as! SelfLogInVC
            self.navigationController?.pushViewController(vc, animated: true)
        })
    }
}

class LogInBtn: UIButton{
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        //let frameHalfWidth = self.frame.width / 2
        let frameHalfHeight = (self.frame.height / 2)
        self.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: (self.frame.width - self.titleLabel!.frame.width)-(frameHalfHeight*4))
        print(self.imageEdgeInsets)
        self.tintColor = .black
        self.layer.cornerRadius = CGFloat(Int(self.frame.height / 2))
        self.layer.borderWidth = 2
    }
}
struct onBoardData{
    let title: String
    let contents:String
    let imageName:String
}
class OnBoardingSlider: UIView,SliderDelegate{
    var data: [onBoardData] = [//취향을 잇는 거래,\n 번개장터
        onBoardData(title: "hELLO WORLD\n nice to meet you", contents: "요즘 유행하는 메이저 취향부터\n 나만 알고 싶은 마이너 취향까지", imageName: "onboard1"),
        //안전하게 취향을 잇습니다 //안전하게\n 취향을 잇습니다.
        onBoardData(title: "hELLO WORLD\n nice to meet you", contents: "번개톡, 번개페이로\n거래의 시작부터 끝까지 안전하게", imageName: "onboard2"),
        onBoardData(title: "편리하게 취향을 잇습니다.", contents: "포장택배 서비스로 픽업/포장/배송을 한번에", imageName: "onboard3"),
        onBoardData(title: "번개장터에서\n취향을 거래해보세요.", contents: "지금 바로 번개장터에서\n당신의 취향에 맞는 아이템을 찾아보세요!", imageName: "onboard4")]
    var onBoardSliderManager: OnBoardSliderManager?
    var sliderCollection: UICollectionView!
    var sliderPageControl: UIPageControl!
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        onBoardSliderManager = OnBoardSliderManager(data: self.data, updater: self)
        self.sliderCollection = UICollectionView(frame: .zero, collectionViewLayout: OnBoardSliderManager.createSliderCompositionalLayout())
        self.sliderCollection.register(UINib(nibName: "OnBoardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "OnBoardCollectionViewCell")
        self.sliderCollection.dataSource = onBoardSliderManager
        self.sliderCollection.delegate = onBoardSliderManager
        self.sliderCollection.collectionViewLayout = OnBoardSliderManager.createSliderCompositionalLayout()
        //Page Controller
        self.sliderPageControl = UIPageControl()
        self.sliderPageControl.pageIndicatorTintColor = .systemGray5
        self.sliderPageControl.currentPageIndicatorTintColor = UIColor.black
        self.sliderPageControl.numberOfPages = (self.onBoardSliderManager?.data.count)!
        self.sliderPageControl.currentPage = self.onBoardSliderManager!.nowIdx
        self.layout()
    }
    private func layout(){
        self.sliderPageControl.translatesAutoresizingMaskIntoConstraints = false
        self.sliderCollection.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(sliderCollection)
        self.addSubview(sliderPageControl)
        NSLayoutConstraint.activate([
            self.sliderCollection.topAnchor.constraint(equalTo: self.topAnchor),
            self.sliderCollection.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.sliderCollection.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.sliderCollection.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.sliderPageControl.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -5),
            self.sliderPageControl.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    func setData(data:[onBoardData]){
        self.data = data
        self.onBoardSliderManager?.setData(data: self.data)
    }
    func numberOfPages(count: Int){
        self.sliderPageControl.numberOfPages = count
    }
    func currentPage(index: Int){
        self.sliderPageControl.currentPage = index
    }
}


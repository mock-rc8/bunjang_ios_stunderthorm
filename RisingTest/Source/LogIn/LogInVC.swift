//
//  LogInVC.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/21.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser
import AuthenticationServices
extension Notification.Name{
    static let LogIn = Notification.Name("LogIn")
}
class LogInVC: UIViewController{
    @IBOutlet weak var kakaoLoginBtn: LogInBtn!
    @IBOutlet weak var appleLogInView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        kakaoLoginBtn.backgroundColor = .yellow
        kakaoLoginBtn.layer.borderColor = UIColor(white: 1, alpha: 1).cgColor
        self.appleLogInView.layer.borderColor = UIColor.black.cgColor
        NotificationCenter.default.addObserver(self, selector: #selector(goHome(notification:)), name: Notification.Name.LogIn, object: nil)
        // Apple Login Button
        let appleLoginButton = ASAuthorizationAppleIDButton()
        appleLoginButton.translatesAutoresizingMaskIntoConstraints = false
        self.appleLogInView.addSubview(appleLoginButton)
        appleLoginButton.topAnchor.constraint(equalTo: appleLogInView.topAnchor).isActive = true
        appleLoginButton.bottomAnchor.constraint(equalTo: appleLogInView.bottomAnchor).isActive = true
        appleLoginButton.leadingAnchor.constraint(equalTo: appleLogInView.leadingAnchor).isActive = true
        appleLoginButton.trailingAnchor.constraint(equalTo: appleLogInView.trailingAnchor).isActive = true
        appleLoginButton.addTarget(self, action: #selector(appleLogin(_:)), for: .touchUpInside)
    }
    @objc func goHome(notification: Notification?){
        self.navigationController?.popToRootViewController(animated: true)
        let splashStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let splashViewController = splashStoryboard.instantiateViewController(identifier: "MainTabBarController")
        NotificationCenter.default.removeObserver(self, name: Notification.Name.LogIn, object: nil)
        self.changeRootViewController(splashViewController)
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
        self.kakaoLogin()
    }
    @IBAction func tampMainBtn(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name.LogIn,object: nil,userInfo:nil)
    }
}
//MARK: -- Kakao Login
extension LogInVC{
    fileprivate func kakaoLogin(){
        // 카카오톡 설치 여부 확인
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoTalk() success.")
                    //do something
                    _ = oauthToken
                }
            }
        }else{
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoAccount() success.")
                    //do something
                    _ = oauthToken
                }
            }
        }
    }
}
// MARK: Apple Login
extension LogInVC: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    @objc func appleLogin(_ sender: ASAuthorizationAppleIDButton) {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.email, .fullName]
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let credential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let userIdentifier = credential.user
            let email = credential.email
            let familyName = credential.fullName?.familyName ?? ""
            let givenName = credential.fullName?.givenName ?? ""
            let fullName = familyName + givenName
            
            self.presentAlert(
                title: "애플로그인 성공",
                message: """
                    userIdentifier : \(userIdentifier)
                    email : \(email ?? "불러오지 못함")
                    fullName : \((fullName.count > 0) ? fullName : "불러오지 못함")
                """
            )
            
            // 자동로그인을 위해 토근 저장
            UserDefaults.standard.set(userIdentifier, forKey: "AppleLoginUserIdentifier")
        } else {
            self.presentAlert(title: "애플로그인 실패")
        }
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
class AppleLogInView: UIView{
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
struct OnboardData{
    let title: String
    let contents:String
    let imageName:String
}
class OnBoardingSlider: UIView,SliderDelegate{
    var data: [OnboardData] = [//
        OnboardData(title: "취향을 잇는 거래,\n 번개장터", contents: "요즘 유행하는 메이저 취향부터\n 나만 알고 싶은 마이너 취향까지", imageName: "onboard1"),
        //안전하게 취향을 잇습니다 //안전하게\n 취향을 잇습니다.
        OnboardData(title: "안전하게\n 취향을 잇습니다.", contents: "번개톡, 번개페이로\n거래의 시작부터 끝까지 안전하게", imageName: "onboard2"),
        OnboardData(title: "편리하게\n 취향을 잇습니다.", contents: "포장택배 서비스로 픽업/포장/배송을 한번에", imageName: "onboard3"),
        OnboardData(title: "번개장터에서\n취향을 거래해보세요.", contents: "지금 바로 번개장터에서\n당신의 취향에 맞는 아이템을 찾아보세요!", imageName: "onboard4")]
    var onBoardSliderManager: OnboardSliderManager?
    var sliderCollection: UICollectionView!
    var sliderPageControl: UIPageControl!
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        onBoardSliderManager = OnboardSliderManager(data: self.data, updater: self)
        self.sliderCollection = UICollectionView(frame: .zero, collectionViewLayout: OnboardSliderManager.createSliderCompositionalLayout())
        self.sliderCollection.register(UINib(nibName: "OnBoardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "OnBoardCollectionViewCell")
        self.sliderCollection.dataSource = onBoardSliderManager
        self.sliderCollection.delegate = onBoardSliderManager
        self.sliderCollection.alwaysBounceVertical = false
        self.sliderCollection.collectionViewLayout = OnboardSliderManager.createSliderCompositionalLayout()
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
    func setData(data:[OnboardData]){
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


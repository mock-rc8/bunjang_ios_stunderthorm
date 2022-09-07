//
//  HomeVC.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/24.
//

import Foundation
import UIKit
extension Notification.Name{
    static let ScrollToTop = Notification.Name("ScrollToTop")
    static let ZzimOn = Notification.Name("ZzimOn")
    static let ZzimOff = Notification.Name("ZzimOff")
}
class HomeVC: MainUIViewController{
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var homeBannerView: HomeImgSlider!
    @IBOutlet weak var headerStack: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!
    var headerFrameHeight : CGFloat?
    override func viewDidLoad() {
        super.viewDidLoad()
        homeBannerView.setPushVC(self)
        self.scrollView.delegate = self
        self.scrollView.showsVerticalScrollIndicator = false
        NotificationCenter.default.addObserver(self, selector: #selector(ScrollToTop(notification:)), name: Notification.Name.ScrollToTop, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(zzimOn(notification:)), name: Notification.Name.ZzimOn, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(zzimOff(notification:)), name: Notification.Name.ZzimOff, object: nil)
        print("headerStack")
        self.headerFrameHeight = self.headerStack.frame.height
        self.tabBarController?.tabBar.isHidden = false

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        self.headerLabel.text = "\(Variable.USER_NAME)님을 위한\n추천 상품 보고 가세요👀👇"
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.setShowNav()
    }
    // 푸시지만 present와 같은 에니메이션
    @IBAction func hamburgerAction(_ sender: UIBarButtonItem) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "HomeStoryboard", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: EntireMenuVC.identifier) as! EntireMenuVC
        let navigationController = self.navigationController
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromTop
        navigationController?.view.layer.add(transition, forKey: nil)
        navigationController?.pushViewController(vc, animated: false)
    }
    @IBAction func alertBtnAction(_ sender: UIBarButtonItem) {
        let vc = UIStoryboard(name: "AlertStoryboard", bundle: nil).instantiateViewController(withIdentifier: AlertVC.identifier) as! AlertVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    deinit{
        NotificationCenter.default.removeObserver(self, name: Notification.Name.ScrollToTop, object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name.ZzimOn, object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name.ZzimOff, object: nil)
    }
}
//MARK: -- 노티피케이션 설정
extension HomeVC{
    @objc func ScrollToTop(notification: Notification){
        print(self.headerStack.frame.height - self.headerLabel.frame.height)
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, options: [], animations: {
            self.scrollView.contentOffset.y = (self.headerStack.frame.height - self.headerLabel.frame.height - 92)
            self.view.layoutIfNeeded()
        })
    }
    @objc func zzimOn(notification: Notification){
        self.presentBottomAlert(message: "찜 목록에 추가되었어요!")
    }
    @objc func zzimOff(notification: Notification){
        self.presentBottomAlert(message: "찜 해제가 완료되었습니다.")
    }
}
extension HomeVC:UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        //let headerWrapperHeight = headerStack.frame.height // label + spacer (102)
        let isEnableScroll = y > (self.headerStack.frame.height - self.headerLabel.frame.height - 92) && y < 500
        if isEnableScroll == true {
            NotificationCenter.default.post(name: Notification.Name.ScrollEnabled,object: nil,userInfo:nil)
        }else{
            NotificationCenter.default.post(name: Notification.Name.ScrollDisabld,object: nil,userInfo:nil)
        }
        if y > 10{
            self.setShowNav()
        }else{
            self.setHideNav()
        }
    }
    func setHideNav(){
        let navigationAppearance = UINavigationBarAppearance()
        navigationAppearance.backgroundColor = .clear
        navigationAppearance.shadowColor = .clear
        navigationAppearance.configureWithTransparentBackground()
        self.navigationController?.navigationBar.standardAppearance = navigationAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = navigationAppearance
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationItem.rightBarButtonItems?.forEach{ $0.tintColor = .white }
        self.navigationItem.leftBarButtonItems?.forEach{ $0.tintColor = .white }
        self.view.layoutIfNeeded()
    }
    func setShowNav(){
            let navigationAppearance = UINavigationBarAppearance()
            navigationAppearance.backgroundColor = .white
            navigationAppearance.shadowColor = .clear
            self.navigationController?.navigationBar.standardAppearance = navigationAppearance
            self.navigationController?.navigationBar.scrollEdgeAppearance = navigationAppearance
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationItem.rightBarButtonItems?.forEach{ $0.tintColor = .black }
            self.navigationItem.leftBarButtonItems?.forEach{ $0.tintColor = .black }
            self.view.layoutIfNeeded()
    }
}
extension HomeVC{
    func setStatusBar(_ color: UIColor){
        if #available(iOS 13.0, *) {
            let app = UIApplication.shared
            let statusBarHeight: CGFloat = app.statusBarFrame.size.height
            let statusbarView = UIView()
            statusbarView.backgroundColor = color
            view.addSubview(statusbarView)
          
            statusbarView.translatesAutoresizingMaskIntoConstraints = false
            statusbarView.heightAnchor
                .constraint(equalToConstant: statusBarHeight).isActive = true
            statusbarView.widthAnchor
                .constraint(equalTo: view.widthAnchor, multiplier: 1.0).isActive = true
            statusbarView.topAnchor
                .constraint(equalTo: view.topAnchor).isActive = true
            statusbarView.centerXAnchor
                .constraint(equalTo: view.centerXAnchor).isActive = true
          
        } else {
            let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
            statusBar?.backgroundColor = color
        }
    }
}

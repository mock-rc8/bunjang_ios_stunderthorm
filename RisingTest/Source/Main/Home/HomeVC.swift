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
        print("headerStack")
        self.headerFrameHeight = self.headerStack.frame.height
        self.tabBarController?.tabBar.isHidden = false
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        let tabbarvc = self.tabBarController as! MainTabbarController
//        tabbarvc.tabBarDidLoad(vc: self)
//    }
    @objc func ScrollToTop(notification: Notification){
        print(self.headerStack.frame.height - self.headerLabel.frame.height)
        print(self.headerLabel.frame.height)
        print(self.headerStack.frame.height)
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, options: [], animations: {
            self.scrollView.contentOffset.y = (self.headerStack.frame.height - self.headerLabel.frame.height)
            self.view.layoutIfNeeded()
        })
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
    deinit{
        NotificationCenter.default.removeObserver(self, name: Notification.Name.ScrollToTop, object: nil)
    }
}
extension HomeVC:UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y

        //let headerWrapperHeight = headerStack.frame.height // label + spacer (102)
        let isEnableScroll = y > (self.headerStack.frame.height - self.headerLabel.frame.height)
        if isEnableScroll == true{
            NotificationCenter.default.post(name: Notification.Name.ScrollEnabled,object: nil,userInfo:nil)
        }else{
            NotificationCenter.default.post(name: Notification.Name.ScrollDisabld,object: nil,userInfo:nil)
        }
    }
}

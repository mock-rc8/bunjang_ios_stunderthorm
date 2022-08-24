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
class HomeVC: UIViewController{
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var homeBannerView: HomeImgSlider!
    @IBOutlet weak var headerStack: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!
    var headerFrameHeight : CGFloat?
    override func viewDidLoad() {
        homeBannerView.setPushVC(self)
        super.viewDidLoad()
        self.scrollView.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(ScrollToTop(notification:)), name: Notification.Name.ScrollToTop, object: nil)
        print("headerStack")
        self.headerFrameHeight = self.headerStack.frame.height
    }
    @objc func ScrollToTop(notification: Notification){
        print(self.headerStack.frame.height - self.headerLabel.frame.height)
        print(self.headerLabel.frame.height)
        print(self.headerStack.frame.height)
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, options: [], animations: {
            self.scrollView.contentOffset.y = (self.headerStack.frame.height - self.headerLabel.frame.height)
            self.view.layoutIfNeeded()
        })
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

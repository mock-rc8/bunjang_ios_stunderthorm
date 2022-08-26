//
//  TalkVC.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/24.
//

import Foundation
import UIKit
class TalkVC: MainUIViewController{
    @IBOutlet weak var innerTableView: UIView!
    @IBOutlet weak var wrapperStack: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!
    var innerTableVC: TempTableVC?
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "embedContainer" {
            self.innerTableVC = (segue.destination as! TempTableVC)
            //tempTableVC.toggleScroll()
        }
    }
}
extension TalkVC:UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        let isEnableScroll = y > (self.wrapperStack.frame.height - 20)
        
        //print("\(y) HeaderHeight: \(self.wrapperStack.frame.height)"
//        self.innerTableVC?.setScrollEnable = isEnableScroll
        if isEnableScroll == true{
            if let tableVC = self.innerTableVC {
                DispatchQueue.main.async {
                    tableVC.tableView.isScrollEnabled = true
                    print("scroll \(tableVC.tableView.isScrollEnabled)")
                }
            }else{
                print("불가능")
            }
        }else{
            if let tableVC = self.innerTableVC {
                DispatchQueue.main.async {
                    tableVC.tableView.isScrollEnabled = false
                    print("scroll \(tableVC.tableView.isScrollEnabled)")
                }
        }
        print(isEnableScroll)
        }
        UIView.animate(withDuration: 0.3) {
//            self.HeaderWrapper.alpha = swipingDown ? 1.0 : 0.0
        }

//        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, options: [], animations: {
//            self.headerViewTopConstraint?.constant = shouldSnap ? -headerWrapperHeight : 0
//            self.view.layoutIfNeeded()
//        })
    }
}

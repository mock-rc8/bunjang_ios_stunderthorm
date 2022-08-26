//
//  MainTabbarController.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/27.
//

import Foundation
import UIKit
protocol CustomTabBarControllerDelegate {
    func onTabSelected(isTheSame: Bool)
}
class MainTabbarController: UITabBarController,UITabBarControllerDelegate{
    var lastVC : UIViewController?
    var nowVC: UIViewController?
    var lastIndex: Int?
    var isInit = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isInit == false{
        self.lastIndex = self.selectedIndex
            isInit.toggle()
        }
    }
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let selectedIndex = tabBarController.viewControllers?.firstIndex(of: viewController)!
        switch viewController{
        case is SearchBtnVC:
            self.selectedIndex = self.lastIndex!
        case is RegisterBtnVC:
            self.selectedIndex = self.lastIndex!
        default:
            self.lastIndex = selectedIndex
        }
    }
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let selectedIndex = tabBar.items?.firstIndex(of: item)!
        switch selectedIndex{
        case 1:
            DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: SearchVC.identifer) as! SearchVC
                self.nowVC?.navigationController?.pushViewController(vc, animated: true)
            }
        case 2:
            DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: RegiVC.identifer) as! RegiVC
                let navigationController = self.nowVC?.navigationController!
                let transition = CATransition()
                transition.duration = 0.5
                transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
                transition.type = CATransitionType.moveIn
                transition.subtype = CATransitionSubtype.fromTop
                navigationController!.view.layer.add(transition, forKey: nil)
                navigationController!.pushViewController(vc, animated: false)
            }
        default:
            break
        }
    }
    public func tabBarDidLoad(vc: UIViewController) {
        self.nowVC = vc
    }
}
class SearchBtnVC: UIViewController{}
class RegisterBtnVC: UIViewController{}
class MainUIViewController : UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        let tabbarController = self.tabBarController as! MainTabbarController
        tabbarController.tabBarDidLoad(vc: self)
    }
}

//
//  MyInterVC.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/09/05.
//


import Foundation
import Tabman
import Pageboy
import UIKit

class MyInterVC: TabmanViewController{
    static let identifier = "MyInterVC"
    private var viewControllers = [
        {
        let storyboard = UIStoryboard(name: "MyStoryboard", bundle: nil)
            let nextVC = storyboard.instantiateViewController(withIdentifier: ZzimVC.identifier) as! ZzimVC
        return nextVC
        }(), {
        let storyboard = UIStoryboard(name : "MyStoryboard", bundle: nil)
            let nextVC = storyboard.instantiateViewController(withIdentifier: RecentVC.identifier) as! RecentVC
        return nextVC
        }()
    ] as [UIViewController]
    private let pageName = ["찜","최근 본 상품"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = true
        self.dataSource = self
        // Create bar
        let bar = TMBar.ButtonBar()
        bar.layout.transitionStyle = .progressive // Customize
        bar.layout.contentMode = .fit
        bar.backgroundColor = .white
        bar.buttons.customize { (button) in
            button.selectedTintColor = .black
            button.font = UIFont.systemFont(ofSize: 18)
            button.selectedFont = UIFont.systemFont(ofSize: 18, weight: .medium)
        }
        bar.indicator.tintColor = .black
        bar.indicator.weight = .custom(value: 3)
        let systemBar = bar.systemBar()
        systemBar.backgroundStyle = .blur(style: .light)
        //bar.backgroundColor = .white
        //systemBar.backgroundStyle = .clear//.blur(style: .light)
        // Add to view
        addBar(systemBar, dataSource: self, at: .top)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension MyInterVC: PageboyViewControllerDataSource,TMBarDataSource{
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    func viewController(for pageboyViewController: PageboyViewController,
                        at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }

    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }

    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        return TMBarItem(title: self.pageName[index])
    }
}


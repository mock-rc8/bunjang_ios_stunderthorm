//
//  HomeTabVC.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/24.
//

import Foundation
import Tabman
import Pageboy
import UIKit

class HomeTabVC: TabmanViewController{
    private var viewControllers = [
        {
        let storyboard = UIStoryboard(name: "HomeStoryboard", bundle: nil)
            let nextVC = storyboard.instantiateViewController(withIdentifier: RecommendTabVC.identifier) as! RecommendTabVC
        return nextVC
        }(), {
        let storyboard = UIStoryboard(name : "HomeStoryboard", bundle: nil)
            let nextVC = storyboard.instantiateViewController(withIdentifier:BrandTabVC.identifier) as! BrandTabVC
        return nextVC
        }()
    ] as [UIViewController]
    private let pageName = ["추천상품","브랜드"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.dataSource = self
        // Create bar
        let bar = TMBar.ButtonBar()
        bar.layout.transitionStyle = .progressive // Customize
        bar.layout.contentMode = .intrinsic
        bar.backgroundColor = .white
        bar.buttons.customize { btn in
            btn.tintColor = .gray
            btn.selectedTintColor = .black
        }
        //bar.layout.interButtonSpacing = 20
        bar.layout.contentInset = UIEdgeInsets(top: 0.0, left: 20.0, bottom: 0.0, right: 20.0)
        bar.layoutMargins.left = 100
        bar.indicator.tintColor = .black
        bar.indicator.weight = .medium
        let systemBar = bar.systemBar()
        systemBar.backgroundStyle = .blur(style: .light)
        systemBar.layoutMargins.left = 100
        self.isScrollEnabled = false
        //bar.backgroundColor = .white
        //systemBar.backgroundStyle = .clear//.blur(style: .light)
        // Add to view
        addBar(systemBar, dataSource: self, at: .top)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension HomeTabVC: PageboyViewControllerDataSource,TMBarDataSource{
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


//
//  EntireMenuVC.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/25.
//

import Foundation
import UIKit
class EntireMenuVC:UIViewController{
    static let identifier = "EntireMenuVC"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = {
            let item = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(self.closeView))
            item.image = UIImage(systemName: "xmark")
            item.tintColor = .black
            return item
        }()
        self.view.backgroundColor = .white
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        self.tabBarController?.tabBar.isHidden = true
    }
    @objc func closeView() {
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromBottom
        navigationController?.view.layer.add(transition, forKey: nil)
        _ = navigationController?.popViewController(animated: false)
    }
}

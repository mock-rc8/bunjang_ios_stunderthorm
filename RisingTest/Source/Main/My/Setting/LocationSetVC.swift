//
//  LocationSetVC.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/28.
//

import Foundation
import UIKit
class LocationSetVC:UIViewController{
    static let identifier = "LocationSetVC"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationSettings()
    }
    
 
}
//MARK: -- Location NavigationSettings
extension LocationSetVC{
    func navigationSettings(){
        self.navigationItem.leftBarButtonItem = {
            let item = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(self.closeView))
            item.image = UIImage(systemName: "arrow.left")
            item.tintColor = .black
            return item
        }()
        self.view.backgroundColor = .white
        self.navigationItem.title = "지역 선택하기"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItem?.tintColor = .red
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

//
//  AlertVC.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/31.
//

import Foundation
import UIKit
class AlertVC: UIViewController{
    static let identifier = "AlertVC"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItems = [UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backVC)),LabelBarButtonItem(text: "알림")
        ]
        self.navigationItem.leftBarButtonItem?.tintColor = .black
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(mainOption))
        self.navigationItem.rightBarButtonItem?.tintColor = .black
    }
    @objc func backVC(){
        self.navigationController?.popViewController(animated: true)
    }
    @objc func mainOption(){
        let vc = UIStoryboard(name: "SettingStoryboard", bundle: nil).instantiateViewController(withIdentifier: AlertSetVC.identifier) as! AlertSetVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

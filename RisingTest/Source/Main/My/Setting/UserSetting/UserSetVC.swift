//
//  AccountVC.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/09/01.
//

import Foundation
import UIKit

class UserSetVC: UIViewController{
    static let identifier = "UserSetVC"
    @IBOutlet weak var phoneLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let phoneNum = "\(Variable.USER_PHONE)"
        print(phoneNum)
        let phone = Variable.getUser_Phone(Variable.USER_PHONE)
        self.phoneLabel.text = "\(phone.first)-****-\(phone.second)"
        
        self.navigationItem.leftBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(closeFn)),
            LabelBarButtonItem(text:"계정 설정")
        ]
        self.navigationItem.leftBarButtonItems?.forEach({ view in
            view.tintColor = .black
        })
    }
    @objc func closeFn(){
        self.navigationController?.popViewController(animated: true)
    }
}

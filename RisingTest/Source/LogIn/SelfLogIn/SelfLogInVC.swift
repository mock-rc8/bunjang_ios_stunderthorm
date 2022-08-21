//
//  SelfLogInVC.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/21.
//

import UIKit
class SelfLogInVC:UIViewController{
    static let identifier = "SelfLogInVC"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        //self.navigationController?.title = "안녕하세요!!"
        self.navigationItem.setHidesBackButton(true, animated: true)
        let barBtn = UIBarButtonItem(image:UIImage(systemName: "chevron.left")!, style: .plain, target: self, action: #selector(backBtn))
        barBtn.tintColor = .black
        self.navigationItem.setLeftBarButton(barBtn, animated: true)
    }
    @objc func backBtn(){
        print("hello world")
        self.navigationController?.popViewController(animated: true)
    }
}

//
//  AccountSetVC.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/09/01.
//

import Foundation
import UIKit
class AccountSetVC:UIViewController{
    @IBOutlet weak var appendBtn: UIButton!
    @IBOutlet weak var accountStack: UIStackView!
    @IBOutlet weak var alarmStack: UIStackView!
    static let identifier = "AccountSetVC"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.appendBtn.setUnderline()
        if Variable.MY_ACCOUNT.count == 0{
            self.accountStack.isHidden = true
            self.alarmStack.isHidden = false
        }else{
            var idx = 0
            self.accountStack.isHidden = false
            Variable.MY_ACCOUNT.forEach { str in
                accountStack.subviews[idx].isHidden = false
                let label = accountStack.subviews[idx].subviews[0] as! UILabel
                label.text = str
                idx += 1
            }
            self.alarmStack.isHidden = true
        }
        self.navigationItem.leftBarButtonItem =             UIBarButtonItem(image: UIImage(systemName: ""), style: .plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeFn))
        self.navigationItem.rightBarButtonItem?.tintColor = .black
    }
    @objc func closeFn(){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func closeBtnAction(_ sender: UIButton) {
    }
}

//
//  MyStoreVC.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/09/02.
//

import Foundation
import UIKit
class MyStoreVC: UIViewController{
    @IBOutlet weak var myNameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dismissKeyboardWhenTappedAround()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(closeFn))
        self.myNameTextField.text = Variable.USER_NAME
    }
    @objc func closeFn(){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func applyBtn(_ sender: UIButton) {
        if myNameTextField.text == ""{
            self.presentBottomAlert(message: "닉네임이 비어있습니다.")
        }else{
            Variable.USER_NAME = self.myNameTextField.text!
            self.navigationController?.popViewController(animated: true)
        }
    }
}

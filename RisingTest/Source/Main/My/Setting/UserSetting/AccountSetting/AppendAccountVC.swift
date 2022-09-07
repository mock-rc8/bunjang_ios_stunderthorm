//
//  AppendAccountVC.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/09/01.
//

import Foundation
import UIKit
class AppendAccountVC:UIViewController{
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var bankTextField: UITextField!
    @IBOutlet weak var accountTextField: UITextField!
    static let identifier = "AppendAccountVC"
    var isSave = false
    @IBOutlet weak var completeBtn: UIButton!
    var arrTextField : [UITextField]?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem =             UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(closeFn))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeFn))
        self.navigationItem.leftBarButtonItem?.tintColor = .black
        self.navigationItem.rightBarButtonItem?.tintColor = .black
        self.nameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        self.bankTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        self.accountTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        self.arrTextField = [nameTextField,accountTextField,bankTextField]
    }
    func btnStyle(){
        if self.isSave{
            self.completeBtn.backgroundColor = .red
        }else{
            self.completeBtn.backgroundColor = #colorLiteral(red: 1, green: 0.1764705882, blue: 0.3333333333, alpha: 0.1978120279)
        }
    }
    @objc func closeFn(){
        self.navigationController?.popViewController(animated: true)
    }
    @objc func textFieldDidChange(_ sender: Any?) {
        let idx: Int? = self.arrTextField?.firstIndex(where: { textField in
            return textField.text == ""
        })
        if idx == nil{
            self.isSave = true
            self.btnStyle()
        }else{
            self.isSave = false
            self.btnStyle()
        }
    }
    @IBAction func completeAction(_ sender: UIButton) {
        Variable.MY_ACCOUNT.append(self.accountTextField.text!)
        closeFn()
    }
    @IBAction func appendBtnAction(_ sender: UIButton) {
        print("btnAction")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: AccountModalVC.identifier) as! AccountModalVC
        vc.completionAction = { data in
            self.bankTextField.text = data
        }
        presentPanModal(vc)
    }
}

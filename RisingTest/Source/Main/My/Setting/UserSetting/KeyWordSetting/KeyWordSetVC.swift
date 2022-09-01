//
//  KeyWordSetVC.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/09/01.
//

import Foundation
import UIKit
class KeyWordSetVC: UIViewController{
    var idx = 0
    var nowCnt = 0
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var innerStack: UIStackView!
    static let identifier = "KeyWordSetVC"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textField.delegate = self
        self.innerStack.subviews.forEach { view in
            view.isHidden = true
        }
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(closeFn))
    }
    @objc func closeFn(){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnAction(_ sender: UIButton) {
        self.innerStack.subviews.forEach { view in
            let btn = view.subviews[1] as! UIButton
            if btn == sender{
                view.isHidden = true
            }
        }
        self.nowCnt -= 1
        self.countLabel.text = String(self.nowCnt)
    }
    func addItem(){
        self.nowCnt += 1
        self.countLabel.text = String(self.nowCnt)
        let label = self.innerStack.subviews[idx].subviews[0] as! UILabel
        label.text = self.textField.text
        self.innerStack.subviews[idx].isHidden = false
        self.idx += 1
    }
}
extension KeyWordSetVC: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.textField {
            resignFirstResponder()
            self.addItem()
            self.textField.text = ""
      }
      return true
    }
}

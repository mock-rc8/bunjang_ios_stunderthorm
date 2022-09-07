//
//  UserPhoneVC.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/09/02.
//

import Foundation
import UIKit
import PanModal
class UserPhoneVC:UIViewController{
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var textField: UITextField!
    static let identifier = "UserPhoneVC"
    var completion : (()->())?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dismissKeyboardWhenTappedAround()
        self.navigationItem.leftBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(closeFn)),
            LabelBarButtonItem(text:"휴대폰 번호 설정")
        ]
        self.navigationItem.leftBarButtonItems?.forEach({ view in
            view.tintColor = .black
        })
        self.textField.becomeFirstResponder()
    }
    
    @objc func closeFn(){
        self.dismiss(animated: true)
    }
    @IBAction func endAction(_ sender: Any) {
        print(textField.text)
        Variable.USER_PHONE = textField.text!
        self.dismiss(animated: true,completion: completion)
    }
}
extension UserPhoneVC : PanModalPresentable {
    
    var panScrollable: UIScrollView? {
        return nil
    }
    
    // 접힌거
    var shortFormHeight: PanModalHeight {
        return .contentHeight(stackView.frame.height)
        //return .contentHeight(300)
    }
    // 완전 펼쳐진거
    var longFormHeight: PanModalHeight {
        return .contentHeight(stackView.frame.height)
    }
    var anchorModalToLongForm: Bool {
        // true 이면 화면 최상단 까지 스크롤 안됨
        return true
        // false 이면 화면 최상단 까지 스크롤 됨
    }
    var allowsDragToDismiss: Bool {
        return false
    }
    var showDragIndicator: Bool {
        return false
    }
}

//
//  RegisterOptionSelectVC.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/25.
//

import Foundation
import UIKit
import PanModal
class RegisterOptionModalVC: UIViewController{
    @IBOutlet weak var countTextField: UITextField!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var exchangeDisableBtn: UIButton!
    @IBOutlet weak var exchangeAbleBtn: UIButton!
    @IBOutlet weak var oldBtn: UIButton!
    @IBOutlet weak var newBtn: UIButton!
    static let identifier = "RegisterOptionModalVC"
    var prodStatus: ProdStatus = .used
    var isexchangable = false
    var lastText = ""
    var itemCount : Int = 1
    var completeAction : ((_ prodStatus:ProdStatus,_ isExchangable:Bool,_ itemCount:Int)->())?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dismissKeyboardWhenTappedAround()
        [oldBtn,newBtn,exchangeAbleBtn,exchangeDisableBtn].forEach { btn in
            btn?.layer.borderWidth = 1
            btn?.layer.cornerRadius = 5
        }
        self.setBtnStyle(on: self.oldBtn, off: self.newBtn)
        self.setBtnStyle(on: self.exchangeDisableBtn, off: self.exchangeAbleBtn)
        self.countTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    @IBAction func selectBtnAction(_ sender: UIButton) {
        switch sender{
        case self.oldBtn:
            self.prodStatus = .used
            self.setBtnStyle(on: self.oldBtn, off: self.newBtn)
        case self.newBtn:
            self.prodStatus = .new
            self.setBtnStyle(on: self.newBtn, off: self.oldBtn)
        case self.exchangeAbleBtn:
            self.isexchangable = true
            self.setBtnStyle(on: self.exchangeAbleBtn, off: self.exchangeDisableBtn)
        case self.exchangeDisableBtn:
            self.isexchangable = false
            self.setBtnStyle(on: self.exchangeDisableBtn, off: self.exchangeAbleBtn)
        default:
            break
        }
    }
    @IBAction func completeSelectBtnAction(_ sender: UIButton) {
        self.itemCount = Int(self.lastText) ?? 0
        self.completeAction!(self.prodStatus,self.isexchangable,self.itemCount)
        self.dismiss(animated: true)
    }
    func setBtnStyle(on: UIButton,off:UIButton){
        DispatchQueue.main.async {
            let red = #colorLiteral(red: 0.846611917, green: 0.04588327557, blue: 0.09413331002, alpha: 1)
            on.layer.borderColor = UIColor.white.cgColor
            on.backgroundColor = #colorLiteral(red: 0.9944986701, green: 0.9352049232, blue: 0.9362998605, alpha: 1)
            on.setTitleColor(red, for: .normal)
            off.layer.borderColor = UIColor.lightGray.cgColor
            off.setTitleColor(.lightGray, for: .normal)
            off.backgroundColor = .white
        }
    }
    
}

extension RegisterOptionModalVC : PanModalPresentable {
    
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
extension RegisterOptionModalVC: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @objc func textFieldDidChange(_ sender: UITextField){
        if 3 < sender.text!.count {
            sender.text = lastText
        }else{
            lastText = sender.text!
        }
    }
}

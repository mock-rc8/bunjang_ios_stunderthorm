//
//  OtherPayModalVC.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/30.
//

import UIKit
import PanModal
class OtherPayModalVC : UIViewController{
    static let identifier = "OtherPayModalVC"
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var payStack: UIStackView!
    var payTextField: UITextField?
    var completion: ((_ myType: PayType)->())?
    var myType: PayType = .none
    override func viewDidLoad() {
        super.viewDidLoad()
        self.payTextField!.text = self.myType.rawValue
        self.completion!(self.myType)
        self.payStack.subviews.forEach { view in
            view.layer.borderWidth = 1
            view.layer.borderColor = UIColor.gray.cgColor
            view.layer.cornerRadius = 20
        }
    }
    @IBAction func typeBtnAction(_ sender: UIButton) {
        var iter = 0
        self.payStack.subviews.forEach { view in
            if view == sender as UIView{
                view.layer.borderColor = UIColor.red.cgColor
                switch iter{
                case 0: myType = .credit
                case 1: myType = .kakaoPay
                case 2: myType = .toss
                case 3: myType = .account
                case 4: myType = .phone
                default: break
                }
            }else{
                view.layer.borderColor = UIColor.gray.cgColor
            }
            iter += 1
        }
        self.payTextField!.text = self.myType.rawValue
        dismiss(animated: true) {
            self.completion!(self.myType)
        }
    }
}

extension OtherPayModalVC : PanModalPresentable {
    
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

//
//  PayRequestModalVC.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/30.
//

import Foundation
import UIKit
import PanModal
class PayRequestModalVC:UIViewController{
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var btnStack: UIStackView!
    static let identifier = "PayRequestModalVC"
    var myTextField : UITextField?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func btnAction(_ sender: Any) {
        self.btnStack.subviews.forEach { myView in
            let btn = myView as! UIButton
            if sender as! UIButton == btn{
                myTextField!.text = btn.titleLabel?.text
            }
        }
        dismiss(animated: true)
    }
}
extension PayRequestModalVC : PanModalPresentable {
    
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



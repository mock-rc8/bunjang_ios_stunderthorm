//
//  SettingModalVC.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/31.
//

import Foundation
import UIKit
import PanModal
class SettingModalVC:UIViewController{
    @IBOutlet weak var stackView: UIStackView!
    static let identifier = "SettingModalVC"
    var completion : (()->())?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //전체 세팅으로 넘어가기
    @IBAction func settingBtnAction(_ sender: Any) {
        self.dismiss(animated: true, completion: completion)
    }
}
extension SettingModalVC : PanModalPresentable {
    
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

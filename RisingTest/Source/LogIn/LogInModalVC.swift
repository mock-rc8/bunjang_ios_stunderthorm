//
//  LogInModalVC.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/21.
//

import UIKit
import PanModal
class LogInModal: UIViewController{
    @IBOutlet weak var faceBookBtn: UIView!
    @IBOutlet weak var naverBtn: UIView!
    @IBOutlet weak var selfBtn: UIView!
    @IBOutlet weak var stackView: UIStackView!
    var completionAction : (()->Void)?
    var myParent : UIViewController?
    static let identifier = "LogInModalVC"
    var idx = 0
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func selfLoginBtn(_ sender: UIButton) {
//        let vc = UIStoryboard(name: "SelfLogInStoryboard", bundle: nil).instantiateViewController(withIdentifier: SelfLogInVC.identifier) as! SelfLogInVC
//        self.myParent?.navigationController?.pushViewController(vc, animated: true)
//        print("canrun")
//        self.completionAction
            self.dismiss(animated: false, completion: nil)
    }
}
extension LogInModal : PanModalPresentable {
    
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


class CircleWrapperView: UIView{
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        let minSize = min(self.layer.frame.width,self.layer.frame.height)
        self.layer.cornerRadius = minSize / 2 - 2
    }
}
class CircleWrapperImageView: UIImageView{
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        let minSize = max(self.layer.frame.width,self.layer.frame.height)
        self.layer.cornerRadius = minSize / 2 - 2
    }
}

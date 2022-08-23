//
//  CarriorModalVC.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/22.
//

import UIKit
import PanModal
enum CarriroName:String,CaseIterable{
    case SKT = "SKT"
    case KT = "KT"
    case LGU = "LG U+"
    case SKT_frugal = "SKT 알뜰폰"
    case KT_frugal = "KT 알뜰폰"
    case LGU_frugal = "LG U+ 알뜰폰"
}
class CarriorModalVC: UIViewController{
    static let identifier = "CarriorModalVC"
    @IBOutlet weak var stackView: UIStackView!
    let carriorName: [String] = CarriroName.allCases.map{$0.rawValue}
    var selectedImgView: UIImageView? = nil
    var parentView: SelfLogInVC?
    override func viewDidLoad() {
        super.viewDidLoad()
        stackView.subviews.enumerated().forEach { (idx,view) in
            let label = view.subviews[0] as! UILabel
            label.text = carriorName[idx]
        }
        if let idx = self.parentView?.selectedCarriorViewIdx{
            selectedBtn(idx)
        }
    }
    @IBAction func tapAction(_ sender: UIButton) {
        if let selectedImgView = selectedImgView {
            selectedImgView.image = UIImage(systemName: "circle")
        }
        let idx : Int = stackView.subviews.firstIndex {$0.subviews[2] == sender}!
        selectedBtn(idx)
        self.parentView?.selectedCarriorViewIdx = idx
        self.parentView?.setCarriorName(carriorName[idx])
        self.parentView?.confirmBtnShow()
        self.parentView?.nextFieldShow()
        self.dismiss(animated: true, completion: nil)
    }
    func selectedBtn(_ idx: Int){
        let viewImg = stackView.subviews[(idx)].subviews[1] as! UIImageView
        viewImg.image = UIImage(systemName: "circle.fill")
        viewImg.tintColor = .red
    }
}
extension CarriorModalVC : PanModalPresentable {
    
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
class CellWrapperView: UIView{
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

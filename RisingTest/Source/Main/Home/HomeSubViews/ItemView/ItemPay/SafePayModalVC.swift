//
//  SafePayModalVC.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/26.
//

import Foundation
import UIKit
import PanModal
class SafePayModalVC: UIViewController{
    static let identifier = "SafePayModalVC"
    @IBOutlet weak var helpBtn: UIButton!
    @IBOutlet weak var btnListStack: UIStackView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var deliveryBtn: UIButton!
    @IBOutlet weak var directBtn: UIButton!
    @IBOutlet weak var directWrapper: UIView!
    @IBOutlet weak var deliveryWrapper: UIView!
    @IBOutlet weak var deliveryImg: UIImageView!
    @IBOutlet weak var directImg: UIImageView!
    var isDelivery = true
    var complation : ((_ isDelivery : Bool)->())?
    override func viewDidLoad() {
        super.viewDidLoad()
        helpBtn.setUnderline()
        btnListStack.subviews.forEach { view in
            view.layer.borderWidth = 1
            view.layer.borderColor = UIColor.lightGray.cgColor
            view.layer.cornerRadius = 5
        }
        self.toggleStyle(on: (deliveryWrapper,deliveryImg), off: (directWrapper,directImg))
    }
    @IBAction func seguePayVCAction(_ sender: UIButton) {
        self.dismiss(animated: true,completion: {
            self.complation!(self.isDelivery)
        })
    }
    @IBAction func toggleBtnAction(_ sender: UIButton) {
        switch sender{
        case self.deliveryBtn:
            self.isDelivery = true
            self.toggleStyle(on: (deliveryWrapper,deliveryImg), off: (directWrapper,directImg))
        case self.directBtn:
            self.isDelivery = false
            self.toggleStyle(on: (directWrapper,directImg), off: (deliveryWrapper,deliveryImg))
        default:
            break
        }
    }
    func toggleStyle(on:(UIView,UIImageView),off:(UIView,UIImageView)){
        on.0.layer.borderColor = UIColor.red.cgColor
        on.1.image = UIImage(systemName: "circle.fill")
        on.1.tintColor = .red
        off.0.layer.borderColor = UIColor.lightGray.cgColor
        off.1.image = UIImage(systemName:  "circle")
        off.1.tintColor = .lightGray
    }
}

extension SafePayModalVC : PanModalPresentable {
    
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

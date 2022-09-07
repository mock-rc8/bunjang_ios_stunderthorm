//
//  MyStoreVC.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/09/02.
//

import Foundation
import UIKit
class MyStoreVC: UIViewController{
    @IBOutlet weak var myNameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dismissKeyboardWhenTappedAround()
        self.navigationSettings()
        self.tabBarController?.tabBar.isHidden = true
        self.myNameTextField.text = Variable.USER_NAME
    }
    @objc func closeFn(){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func applyBtn(_ sender: UIButton) {
        if myNameTextField.text == ""{
            self.presentBottomAlert(message: "닉네임이 비어있습니다.")
        }else{
            Variable.USER_NAME = self.myNameTextField.text!
            self.navigationController?.popViewController(animated: true)
        }
    }
    func navigationSettings(){
        self.navigationItem.leftBarButtonItem = {
            let item = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(closeView))
            item.tintColor = .black
            item.customView = {
                let button = UIButton()
                button.setTitle("  상품소개 편집", for: .normal)
                button.titleLabel?.font = UIFont(name: "System", size: 21)
                button.titleLabel!.font = UIFont.boldSystemFont(ofSize: 18)
                button.setTitleColor(.black, for: .normal)
                button.tintColor = .black
                button.setImage(UIImage(systemName: "chevron.left",withConfiguration: UIImage.SymbolConfiguration(scale: .large)), for: .normal)
                button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
                button.addTarget(self, action: #selector(closeView), for: .touchDown)
                return button
            }()
            return item
        }()
        self.view.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }
    @objc func closeView() {
    
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromBottom
        navigationController?.view.layer.add(transition, forKey: nil)
        _ = navigationController?.popViewController(animated: false)
    }
}

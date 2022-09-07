//
//  RegisterTagVC.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/25.
//

import Foundation
import UIKit
import TagListView
class RegisterTagVC : UIViewController{
    @IBOutlet weak var tagListView: TagListView!
    @IBOutlet weak var tagTextField: UITextField!
    @IBOutlet weak var appendBtn: UIButton!
    @IBOutlet weak var tagViewHeight: NSLayoutConstraint!
    static let identifier = "RegisterTagVC"
    var delegate : ((_ myTags: [String])->())?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tagTextField.delegate = self
        navigationSettings()
        self.tagListView.delegate = self
        tagListView.textFont = UIFont.systemFont(ofSize: 14)
    }
    func navigationSettings(){
        self.navigationItem.leftBarButtonItem = {
            let item = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(closeView))
            item.tintColor = .black
            item.customView = {
                let button = UIButton()
                button.setTitle(" 태그", for: .normal)
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
        self.saveMyTag()
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromBottom
        navigationController?.view.layer.add(transition, forKey: nil)
        _ = navigationController?.popViewController(animated: false)
    }
    func saveMyTag(){
        let myTageList : [String] = self.tagListView.tagViews.map { tagView -> String in
            let text = tagView.titleLabel!.text!
            return text.trimmingCharacters(in: ["#"])
        }
        self.delegate!(myTageList)
    }
    @IBAction func appendBtnAction(_ sender: UIButton) {
        addTagAction()
    }
    func addTagAction(){
        guard self.tagListView.tagViews.count < 5 else {return}
        let text = tagTextField.text
        if let myText = text, text != ""{
            self.tagListView.addTag("#\(myText)")
            self.tagTextField.text = ""
            self.tagViewHeight.constant = self.tagListView.intrinsicContentSize.height
        }
    }
}
extension RegisterTagVC: TagListViewDelegate{
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        
    }
    func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) {
        self.tagListView.removeTagView(tagView)
    }
}
extension RegisterTagVC: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.tagTextField {
            self.addTagAction()
      }
      return true
    }
}

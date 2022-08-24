//
//  AgreeModalVC.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/22.
//

import Foundation
import UIKit
import PanModal
class AgreeModalVC: UIViewController{
    static let identifier = "AgreeModalVC"
    @IBOutlet weak var allAgreeWrapper: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var allAgreeImg: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var confirmBtn: UIButton!
    var isAllAgreeChecked : Bool = false
    var requestData: SignInRequest?
    let dataModel: AgreeDataModel = AgreeDataModel()
    lazy var dataManager: SignInDataManager = SignInDataManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initStyle()
        self.tableView.register(UINib(nibName: AgreeTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: AgreeTableViewCell.identifier)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.confirmBtn.isEnabled = false
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.confirmBtn.layer.cornerRadius = 10
        self.setConfirmStyle()
    }
    @IBAction func allAgreeBtnAction(_ sender: UIButton) {
        if isAllAgreeChecked == true{
            self.dataModel.setAllDataUnchecked()
            self.confirmBtn.isEnabled = false
            self.setConfirmStyle()
        }else {
            self.dataModel.setAllDataChecked()
            self.confirmBtn.isEnabled = true
            self.setConfirmStyle()
        }
        self.isAllAgreeChecked.toggle()
        self.setAllAgreeWrapperStyle()
    }

}
//MARK: -- 회원가입 및 로그인 확인 버튼
extension AgreeModalVC{
    @IBAction func confirmBtnAction(_ sender: UIButton) {
        // Requst Sign In
        //self.dismissKeyboard()
        self.showIndicator()
        dataManager.postSignIn(requestData!, delegate: self)
    }
    func didSuccessSignIn(_ result: SignInResult) {
        self.presentAlert(title: "로그인에 성공하였습니다", message: result.token)
    }
    
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
        NotificationCenter.default.post(name: Notification.Name.LogIn,object: nil,userInfo:nil)
        self.dismiss(animated: false)
    }
}
//MARK: -- AgreeModal Style Method's
extension AgreeModalVC{
    func initStyle(){
        self.allAgreeWrapper.layer.borderWidth = 1
        self.allAgreeWrapper.layer.borderColor = UIColor.gray.cgColor
        self.allAgreeWrapper.layer.cornerRadius = 5
        self.allAgreeImg.tintColor = UIColor.gray
    }
    func setAllAgreeWrapperStyle(){
        if isAllAgreeChecked == true{
            self.allAgreeWrapper.layer.borderColor = UIColor.red.cgColor
            self.allAgreeImg.tintColor = UIColor.red
        }else{
            self.allAgreeWrapper.layer.borderColor = UIColor.gray.cgColor
            self.allAgreeImg.tintColor = UIColor.gray
        }
        self.tableView.reloadData()
    }
    func setConfirmStyle(){
        if self.confirmBtn.isEnabled == false{
            let uiColor:UIColor = #colorLiteral(red: 1, green: 0.1764705882, blue: 0.3333333333, alpha: 0.48)
            self.confirmBtn.backgroundColor = uiColor
        }else{
            self.confirmBtn.backgroundColor = #colorLiteral(red: 1, green: 0.1764705882, blue: 0.3333333333, alpha: 1)
        }
    }
}
extension AgreeModalVC : PanModalPresentable {
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
extension AgreeModalVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AgreeTableViewCell.identifier, for: indexPath) as! AgreeTableViewCell
        let data:AgreeData = dataModel.getData(indexPath.item)
        cell.setStatus(data)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let idx = indexPath.item
        dataModel.toggleCheckData(idx)
        self.isAllAgreeChecked = self.dataModel.isAllChecked
        self.setAllAgreeWrapperStyle()
        self.confirmBtn.isEnabled = self.dataModel.isReqiuiredAllChecked
        self.setConfirmStyle()
    }
}

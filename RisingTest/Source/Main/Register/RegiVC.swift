//
//  RegiVC.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/23.
//

import UIKit

class RegiVC: UIViewController{
    var tempTitle = RegisterRequest(postImg_url: ["https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTl-FrXpdUtIR5iCeVZCp4dGIh3uiENuo9OHg&usqp=CAU", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQKtQope-BdIw_CFcgjw_MWsYKJC4BchgE7ow&usqp=CAU"], tradeRegion: "시흥시 신천동", postTitle: "원피스 Only", categoryIdx: 1, hashTagName: ["미디 원피스"], price: 39800, deliveryFee: "Y", quantity: 1, prodStatus: "중고상품", exchange: "불가", payStatus: "N")
    lazy var dataManager: RegisterDataManager = RegisterDataManager()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func registerBtnAction(_ sender: UIButton) {
        dataManager.postSignIn(self.tempTitle, delegate: self)
    }
    func didSuccessSignIn(_ result: SignInResult) {
        self.presentAlert(title: "로그인에 성공하였습니다", message: result.token)
    }
    
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
}

//
//  RegiVC.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/23.
//

import UIKit

class RegiVC: UIViewController{
    var tempTitle = RegisterRequest(postImg_url: ["https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTl-FrXpdUtIR5iCeVZCp4dGIh3uiENuo9OHg&usqp=CAU", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQKtQope-BdIw_CFcgjw_MWsYKJC4BchgE7ow&usqp=CAU"], tradeRegion: "시흥시 신천동", postTitle: "test", postContent: "testContent", categoryIdx: 1, hashTagName: ["삼성전자", "삼성"], price: 100, deliveryFee: "N", quantity: 1, prodStatus: "중고상품", exchange: "불가", payStatus: "N")
    lazy var dataManager: RegisterDataManager = RegisterDataManager()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func registerBtnAction(_ sender: UIButton) {
        dataManager.postSignIn(self.tempTitle, delegate: self)
    }
    func didSuccessSignIn(_ result: RegisterResult) {
        self.presentAlert(title: "로그인에 성공하였습니다", message: String(result.postIdx))
    }
    
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
}

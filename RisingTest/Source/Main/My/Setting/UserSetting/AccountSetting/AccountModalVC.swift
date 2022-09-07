//
//  AccountModalVC.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/09/07.
//

import Foundation
import UIKit
import UIKit
import PanModal
class AccountModalVC: UIViewController{
    @IBOutlet weak var stackView: UITableView!
    var completionAction : ((_ data:String)->Void)?
    var myParent : UIViewController?
    lazy var data = ["국민은행","우리은행","신한은행","KEB하나은행","카카오뱅크","농협은행","기업은행","토스뱅크"]
    static let identifier = "AccountModalVC"
    var idx = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.stackView.delegate = self
        self.stackView.dataSource = self
        self.stackView.register(UINib(nibName: BankTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: BankTableViewCell.identifier)
    }
}
extension AccountModalVC : PanModalPresentable {
    
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

extension AccountModalVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BankTableViewCell.identifier) as! BankTableViewCell
        cell.titleLabel.text = self.data[indexPath.item]
        cell.titleImg.image = UIImage(named: self.data[indexPath.item])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true, completion: {
            self.completionAction!(self.data[indexPath.item])
        })
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

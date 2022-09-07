//
//  AlertSetVC.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/31.
//

import Foundation
import UIKit
import OrderedCollections
class AlertSetVC:UIViewController{
    @IBOutlet weak var tableView: UITableView!
    static let identifier = "AlertSetVC"
    lazy var alertData : OrderedDictionary<String,[(String,AlertCellType,Bool?)]> = [
        "알림":[("알림 표시",.switcher,false),("방해금지 시간 설정",.switcher,false)],
        "번개톡 채팅 알림":[("메세지를 받았을 때",.switcher,false)],
        "상품 알림":[("상품이 찜 되었을 때",.switcher,false),("내가 찜한 상품이 가격 하락 했을 때",.switcher,false),("UP하기 예약 실행 알림",.switcher,false),
                 ("재판매 가능 상품이 있을 때",.switcher,false),("내 상품으로 가격 제안 받을 때",.switcher,false)],
        "상점 알림":[("상점이 팔로우 되었을 때",.switcher,false),("상점 리뷰가 등록되었을 때",.switcher,false)],
        "배송 알림":[("배송 진행",.switcher,false),("배송이 완료되었을 때",.switcher,false)],
        "이벤트 혜택 알림":[("이벤트 및 혜택 알림 동의",.switcher,false)],
        "관심상품 알림":[("키워드 알림",.normal,false),("팔로잉 상점 알림",.normal,false),("내가 찜한 상품으로 연락받기",.switcher,false)],
        "우리동네 이벤트":[("우리동네 이벤트",.switcher,false)]
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: EntireSetCell.identifier, bundle: nil), forCellReuseIdentifier: EntireSetCell.identifier)
        self.tableView.register(UINib(nibName: AlertSettingCell.identifier, bundle: nil), forCellReuseIdentifier: AlertSettingCell.identifier)
        self.navigationItem.leftBarButtonItems = [UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backVC)),LabelBarButtonItem(text: "알림/부가서비스")
        ]
        self.navigationItem.leftBarButtonItem?.tintColor = .black
        self.tableView.backgroundColor = #colorLiteral(red: 0.9607843757, green: 0.9607843757, blue: 0.9607843757, alpha: 1)
    }
@objc func backVC(){
    self.navigationController?.popViewController(animated: true)
}
}

extension AlertSetVC:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.alertData.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.alertData.values[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let idx = indexPath.item
        let myType = self.alertData.values[indexPath.section][idx].1
        switch myType{
        case .switcher:
            let cell = tableView.dequeueReusableCell(withIdentifier: AlertSettingCell.identifier, for: indexPath) as! AlertSettingCell
            cell.titleLabel.text = self.alertData.values[indexPath.section][idx].0
            cell.switcher.isOn = self.alertData.values[indexPath.section][idx].2 ?? false
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            cell.selectionStyle = .none
            let sectionIdx = indexPath.section
            let itemIdx = indexPath.item
            cell.isOnAct = { myIsOn in
                let myKey = self.alertData.keys[sectionIdx]
                self.alertData[myKey]?[itemIdx].2 = myIsOn
            }
            return cell
        case .normal:
            let cell = tableView.dequeueReusableCell(withIdentifier: EntireSetCell.identifier, for: indexPath) as! EntireSetCell
            cell.selectionStyle = .none
            cell.titlaLabel.text = self.alertData.values[indexPath.section][idx].0
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sectionIdx = indexPath.section
        let itemIdx = indexPath.item
        let myKey = alertData.keys[sectionIdx]
        alertData[myKey]?[itemIdx].2 = !(alertData.values[sectionIdx][itemIdx].2 ?? true)
        //alertData.values[sectionIdx][itemIdx].2 = !(alertData.values[sectionIdx][itemIdx].2 ?? true)
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.alertData.keys[section]
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.red
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.black
        header.textLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}
enum AlertCellType{
    case switcher
    case normal
}

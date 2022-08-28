//
//  ServiceVC.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/25.
//

import Foundation
import UIKit
import OrderedCollections
class ServiceEntireVC: UIViewController{
    static let identifier = "ServiceEntireVC"
    let data : OrderedDictionary<String,[String]> = ["추천":["배송서비스","정품 검수","내폰시세","번개유심","혜택/이벤트","친구초대"],
                                    "자주쓰는":["찜","최근본상품","내피드","우리동네"]]
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: ServiceEntireTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ServiceEntireTableViewCell.identifier)
        self.tableView.register(ServiceEntireHeader.self, forHeaderFooterViewReuseIdentifier: ServiceEntireHeader.identifier)
    }
}
extension ServiceEntireVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.values[section].count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.keys.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ServiceEntireTableViewCell.identifier) as! ServiceEntireTableViewCell
        let myData: String = self.data.values[indexPath.section][indexPath.item]
        if myData == "번개유심"{
            cell.eventLabel.isHidden = false
        }else{
            cell.eventLabel.isHidden = true
        }
        cell.myimageView.image = UIImage(named: myData.replacingOccurrences(of: "/", with: ":"))
        cell.label.text = myData
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = RegisterCategoryVC()
//        var dataList = Array(self.categoryDataList)
//        dataList.append("여성의류")
//        vc.categoryDataList = dataList
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    //헤더 뷰 설정!!
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: ServiceEntireHeader.identifier) as! ServiceEntireHeader
        header.text = data.keys[section]
        return header
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}
class ServiceEntireHeader: UITableViewHeaderFooterView {
    static let identifier = "ServiceEntireHeader"
    var text : String = "" {
        willSet{
            self.label.text = newValue
        }
    }
    private let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 21, weight: .bold)
        label.textAlignment = .left
        return label
    }()
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(label)
    }
    required init?(coder: NSCoder) {
        fatalError("is init error")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        label.sizeToFit()
        label.frame = CGRect(x: 20, y: 0, width: contentView.frame.width, height: contentView.frame.height)
    }
}

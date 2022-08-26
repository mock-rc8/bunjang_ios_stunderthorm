//
//  ServiceVC.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/25.
//

import Foundation
import UIKit
class ServiceEntireVC: UIViewController{
    static let identifier = "ServiceEntireVC"
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ServiceEntireTableViewCell.identifier) as! ServiceEntireTableViewCell
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
        header.text = "추천"
        return header
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }
}
class ServiceEntireHeader: UITableViewHeaderFooterView {
    static let identifier = "ServiceEntireHeader"
    var text :String = "" {
        willSet{
            self.label.text = newValue
        }
    }
    private let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
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
        label.frame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height)
    }
}

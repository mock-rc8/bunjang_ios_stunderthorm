//
//  BrandTabVC.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/24.
//

import Foundation
import UIKit
class BrandEntireVC: UIViewController{
    @IBOutlet weak var tableView: UITableView!
    static let identifier = "BrandEntireVC"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: BrandTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: BrandTableViewCell.identifier)
        print(BrandEntireVC.identifier)
    }
}
extension BrandEntireVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BrandTableViewCell.identifier) as! BrandTableViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
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
        let label = UILabel()
        label.text = "추천"
        return label
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
}


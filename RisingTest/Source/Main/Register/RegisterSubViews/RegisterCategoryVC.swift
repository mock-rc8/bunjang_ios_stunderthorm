//
//  RegisgerCategoryVC.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/25.
//

import Foundation
import UIKit
class RegisterCategoryVC: UIViewController{
    static let identifier = "RegisterCategoryVC"
    lazy var tableView = UITableView()
    var categoryDataList : [String] = ["전체"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        layout()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: RegisterCategoryTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: RegisterCategoryTableViewCell.identifier)
        tableView.register(UINib(nibName: RegisterCategoryHeader.identifier, bundle: nil), forHeaderFooterViewReuseIdentifier: RegisterCategoryHeader.identifier)
    }
    
    func layout(){
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.tableView)
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
}

extension RegisterCategoryVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RegisterCategoryTableViewCell.identifier) as! RegisterCategoryTableViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = RegisterCategoryVC()
        var dataList = Array(self.categoryDataList)
        dataList.append("여성의류")
        vc.categoryDataList = dataList
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: RegisterCategoryHeader.identifier) as! RegisterCategoryHeader
        header.setStack(self.categoryDataList)
        return header
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
}

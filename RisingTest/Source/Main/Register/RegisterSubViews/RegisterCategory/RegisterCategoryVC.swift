//
//  RegisgerCategoryVC.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/25.
//

import Foundation
import UIKit
import OrderedCollections
class RegisterCategoryVC: UIViewController{
    static let identifier = "RegisterCategoryVC"
    lazy var tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: .grouped)
    private var categoryDataList : OrderedDictionary<String,[String]>?
    private var headerList : [String]?
    var pageIdx = 0
    var myRootVC: UIViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        layout()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: RegisterCategoryTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: RegisterCategoryTableViewCell.identifier)
        tableView.register(UINib(nibName: RegisterCategoryHeader.identifier, bundle: nil), forHeaderFooterViewReuseIdentifier: RegisterCategoryHeader.identifier)
        self.navigationItem.leftBarButtonItems = [UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backVC)),LabelBarButtonItem(text: "카테고리")]
        self.navigationItem.leftBarButtonItem?.tintColor = .black
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
    }
    @objc func backVC(){
        self.navigationController?.popViewController(animated: true)
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
    func setCategoryData(_ idx:Int = 0,_ header: [String]? = nil){
        self.pageIdx = idx
        self.categoryDataList = RegisterCategoryData.shared.pageData[self.pageIdx]
        if let header = header {
            self.headerList = header
            self.headerList?.append(String(self.categoryDataList!.keys[0]))
        }else{
            self.headerList = [String(self.categoryDataList!.keys[0])]
        }
    }
}

extension RegisterCategoryVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryDataList!.values[0].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RegisterCategoryTableViewCell.identifier) as! RegisterCategoryTableViewCell
        cell.titleLabel.text = categoryDataList?.values[0][indexPath.item]
        //cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        if (self.pageIdx+1) < RegisterCategoryData.shared.pageData.count{ // 다음 인덱스는 전체 데이터의 수 보다 작아야한다.
            let selectedData: String = (categoryDataList?.values[0][indexPath.item])! //현재 선택된 데이터의 값
            let nextData: String = RegisterCategoryData.shared.pageData[self.pageIdx+1].keys[0] //다음 데이터의 키 값
            cell.setAccessData(selectedData == nextData) //현재 데이터의 키 값과 다음 데이터의 키 값이 같으면 다음 버튼 모양을 표시한다.
        }else{
            cell.setAccessData(false)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedData: String = (categoryDataList?.values[0][indexPath.item])! //현재 선택된 데이터의 값
        if (self.pageIdx+1) < RegisterCategoryData.shared.pageData.count{ // 다음 인덱스는 전체 데이터의 수 보다 작아야한다.
            let nextData: String = RegisterCategoryData.shared.pageData[self.pageIdx+1].keys[0] //다음 데이터의 키 값
            if selectedData ==  nextData{ //현재 데이터의 키 값과 다음 데이터의 키 값이 같으면 다음 데이터로 넘긴다.
                let vc = RegisterCategoryVC()
                vc.setCategoryData(self.pageIdx+1,self.headerList)
                vc.myRootVC = self.myRootVC
                self.navigationController?.pushViewController(vc, animated: true)
                return
            }
        }
        self.headerList?.append(selectedData)
        let idx: Int = RegisterCategoryData.shared.pageData[0].values[0].firstIndex(of: self.headerList![1])!
        NotificationCenter.default.post(name: Notification.Name.Category,object: nil,userInfo: ["ViewData":self.headerList! ,"ServerData": 1])
        self.navigationController?.popToViewController(self.myRootVC!, animated: true)
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: RegisterCategoryHeader.identifier) as! RegisterCategoryHeader
        
        header.setStack(self.headerList!)
        return header
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

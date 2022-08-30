//
//  BrandTabVC.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/24.
//

import Foundation
import UIKit
class BrandEntireVC: UIViewController{
    @IBOutlet weak var mainCalledLabel: UILabel!
    @IBOutlet weak var deliveryFeeBtn: UIButton!
    @IBOutlet weak var filterBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    static let identifier = "BrandEntireVC"
    var deliveryFee = false
    var isHomeCalled = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.filterBtn.semanticContentAttribute = .forceRightToLeft
        self.pushStyle()
        self.tableView.register(UINib(nibName: BrandTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: BrandTableViewCell.identifier)
        self.deliveryBtnStyle()
    }
    func pushStyle(){
        if self.isHomeCalled{
            mainCalledLabel.isHidden = false
            self.navigationController?.isToolbarHidden = false
            self.navigationItem.leftBarButtonItem = {
                let item = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(self.closeView))
                item.image = UIImage(systemName: "chevron.left")
                item.tintColor = .black
                return item
            }()
        }else{
            mainCalledLabel.isHidden = true
            self.navigationController?.isToolbarHidden = true
        }
    }
    @objc func closeView(){
        self.navigationController?.isToolbarHidden = true
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func deliverBtnAction(_ sender: UIButton) {
        self.deliveryFee.toggle()
        self.deliveryBtnStyle()
    }
    func deliveryBtnStyle(){
        if deliveryFee == false{
            self.deliveryFeeBtn.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
            self.deliveryFeeBtn.tintColor = .gray
            
        }else{
                self.deliveryFeeBtn.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
                self.deliveryFeeBtn.tintColor = .red
        }
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
}


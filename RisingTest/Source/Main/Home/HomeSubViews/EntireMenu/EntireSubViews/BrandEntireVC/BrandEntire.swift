//
//  BrandTabVC.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/24.
//

import Foundation
import UIKit
class BrandEntireVC: UIViewController{
    let dummyData = BrandEntireResult(brandIdx: 1, brandImg_url: "", brandName: "페이스북", brandEngName: "FaceBook", postNum: 123)
    let dataManager = BrandEntireDataManager()
    var entireData: [BrandEntireResult]?
    var entireDataImg: [UIImageView]?
    @IBOutlet weak var mainCalledLabel: UILabel!
    @IBOutlet weak var deliveryFeeBtn: UIButton!
    @IBOutlet weak var filterBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    static let identifier = "BrandEntireVC"
    var deliveryFee = false
    var isHomeCalled = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataManager.getItem(delegate: self)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.filterBtn.semanticContentAttribute = .forceRightToLeft
        self.pushStyle()
        self.tableView.register(UINib(nibName: BrandTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: BrandTableViewCell.identifier)
        self.deliveryBtnStyle()
        self.tabBarController?.tabBar.isHidden = true
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
        return self.entireData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BrandTableViewCell.identifier) as! BrandTableViewCell
        let idx = indexPath.item
        cell.selectionStyle = .none
        cell.brandImgView.image = self.entireDataImg?[idx].image ?? UIImage(named: "onboard1")
        //cell.brandImgView.kf.setImage(with: URL(string: self.entireData?[idx].brandImg_url ?? "onboard1"))
        cell.setData(self.entireData?[idx] ?? self.dummyData)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    //헤더 뷰 설정!!
}
//MARK:-- 통신 함수 설정
extension BrandEntireVC:BrandDelegate{
    func didSuccessGetItem(_ result:[BrandEntireResult]){
        print("BrandEntireVC",#function)
        let imgData : [UIImageView] = result.map{(data:BrandEntireResult) -> UIImageView in
            let imageView = UIImageView()
            print(data.brandImg_url)
            imageView.kf.setImage(with: URL(string: data.brandImg_url))
            return imageView
        }
        self.entireDataImg = imgData
        self.entireData = result
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {

            self.tableView.reloadData()
        }
    }
    func failedGetItem(message: String){
        presentBottomAlert(message: message,target:nil,offset: -50)
    }
}

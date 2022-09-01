//
//  AlertVC.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/31.
//

import Foundation
import UIKit
class AlertVC: UIViewController{
    static let identifier = "AlertVC"
    @IBOutlet weak var keywordView: UIView!
    @IBOutlet weak var segementCtr: UISegmentedControl!
    let setHidden = true
    @IBOutlet weak var newScrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItems = [UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backVC)),LabelBarButtonItem(text: "알림")
        ]
        self.navigationItem.leftBarButtonItem?.tintColor = .black
        let font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        self.segementCtr.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        self.toggleTableView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    func toggleTableView(){
        if (self.segementCtr.selectedSegmentIndex == 0){
        self.keywordView.isHidden = self.setHidden
        self.newScrollView.isHidden = !self.setHidden
            self.navigationItem.rightBarButtonItems = [UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(mainOption))]
        }else{
            self.keywordView.isHidden = !self.setHidden
            self.newScrollView.isHidden = self.setHidden
            self.navigationItem.rightBarButtonItems = [
                UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(mainOption)),
                UIBarButtonItem(image: UIImage(systemName: "square.and.pencil"), style: .plain, target: self, action: #selector(mainKeywordOption))]
        }
        self.navigationItem.rightBarButtonItems?.forEach{$0.tintColor = .black}
    }
    @objc func backVC(){
        self.navigationController?.popViewController(animated: true)
    }
    @objc func mainOption(){
        let vc = UIStoryboard(name: "SettingStoryboard", bundle: nil).instantiateViewController(withIdentifier: AlertSetVC.identifier) as! AlertSetVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func mainKeywordOption(){
        let vc = UIStoryboard(name: "SettingStoryboard",bundle: nil).instantiateViewController(withIdentifier: KeyWordSetVC.identifier) as! KeyWordSetVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func segmentChanged(_ sender: Any) {
        toggleTableView()
    }
    @IBAction func appendKeywordBtnAction(_ sender: UIButton) {
        mainKeywordOption()
    }
}

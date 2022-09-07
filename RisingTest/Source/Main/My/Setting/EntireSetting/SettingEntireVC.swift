//
//  SettingEntireVC.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/31.
//

import Foundation
import UIKit
class SettingEntireVC:UIViewController{
    @IBOutlet weak var tableView: UITableView!
    static let identifier = "SettingEntireVC"
    lazy var sectionList = EntireSettingType.allCases
    lazy var userSetList = UserSettingType.allCases
    lazy var serviceSetList = ServiceSettingType.allCases
    lazy var logoutSetList = LogoutType.allCases
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: EntireSetCell.identifier, bundle: nil), forCellReuseIdentifier: EntireSetCell.identifier)
        self.navigationItem.leftBarButtonItems = [UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backVC)),LabelBarButtonItem(text: "설정")                   ]
        self.navigationItem.leftBarButtonItem?.tintColor = .black
        self.tableView.backgroundColor = #colorLiteral(red: 0.9607843757, green: 0.9607843757, blue: 0.9607843757, alpha: 1)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    @objc func backVC(){
        self.navigationController?.popViewController(animated: true)
    }
}

extension SettingEntireVC:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionList.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sectionList[section]{
        case .user:
            return userSetList.count
        case .logout:
            return logoutSetList.count
        case .service:
            return serviceSetList.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EntireSetCell.identifier, for: indexPath) as! EntireSetCell
        let idx = indexPath.item
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        cell.textLabel?.textColor = .darkGray
        switch sectionList[indexPath.section]{
        case .logout:
            cell.titlaLabel.text = logoutSetList[idx].rawValue
        case .service:
            cell.titlaLabel.text = serviceSetList[idx].rawValue
        case .user:
            cell.titlaLabel.text = userSetList[idx].rawValue
        }
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch sectionList[indexPath.section]{
        case .logout:
            let splashStoryboard = UIStoryboard(name: "LogInStoryboard", bundle: nil)
            let splashViewController = splashStoryboard.instantiateViewController(identifier: "LogInNavVC") as! LogInNavVC
            self.changeRootViewController(splashViewController)
        case .service:
            break
        case .user:
            switch userSetList[indexPath.item]{
            case .location:
                let vc = self.storyboard?.instantiateViewController(withIdentifier: LocationSetVC.identifier) as! LocationSetVC
                self.navigationController?.pushViewController(vc, animated: true)
            case .alert:
                let vc = self.storyboard?.instantiateViewController(withIdentifier: AlertSetVC.identifier) as! AlertSetVC
                self.navigationController?.pushViewController(vc, animated: true)
            case .user:
                let vc = self.storyboard?.instantiateViewController(withIdentifier: UserSetVC.identifier) as! UserSetVC
                self.navigationController?.pushViewController(vc, animated: true)
            case .accoount:
                let vc = self.storyboard?.instantiateViewController(withIdentifier: AccountSetVC.identifier) as! AccountSetVC
                self.navigationController?.pushViewController(vc, animated: true)
            default:
                break
            }
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sectionList[section] == .logout ? " " : sectionList[section].rawValue
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.red
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.black
        header.textLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
    }
}

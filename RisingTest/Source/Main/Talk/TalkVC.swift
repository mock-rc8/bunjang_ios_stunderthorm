//
//  TalkVC.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/24.
//

import Foundation
import UIKit
class TalkVC: MainUIViewController{
    @IBOutlet weak var filterBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationSettings()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: TalkTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: TalkTableViewCell.identifier)
        filterBtn.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        filterBtn.titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        filterBtn.imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationSettings()
    }
}
extension TalkVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TalkTableViewCell.identifier, for: indexPath)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
}
//MARK: -- navigation setting
extension TalkVC{
    func navigationSettings(){
        self.navigationItem.leftBarButtonItem = {
            let item = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
            item.image = UIImage(systemName: "")
            return item
        }()
        self.view.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItem = {
            let item = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
            item.tintColor = .black
            item.customView = {
                let button = UIButton()
                button.setTitle("대화설정", for: .normal)
                
                button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
                button.setTitleColor(.darkGray, for: .normal)
                button.setUnderline()
                button.tintColor = .darkGray
                button.addTarget(self, action: #selector(segueLocationView), for: .touchDown)
                return button
            }()
            return item
        }()
    }
    @objc func segueLocationView(){
        let vc = UIStoryboard(name: "SettingStoryboard", bundle: nil).instantiateViewController(withIdentifier: LocationSetVC.identifier) as! LocationSetVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

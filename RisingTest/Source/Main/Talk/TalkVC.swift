//
//  TalkVC.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/24.
//

import Foundation
import UIKit
class TalkVC: MainUIViewController{
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationSettings()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: TalkTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: TalkTableViewCell.identifier)
    }
}
extension TalkVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
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
            let item = LabelBarButtonItem(text: "번개톡", fontName: "System", fontSize: 21, color: .black)
            return item
        }()
        self.view.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = {
            let item = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
            item.image = UIImage(systemName: "ellipsis")
            item.tintColor = .gray
            return item
        }()
    }
}

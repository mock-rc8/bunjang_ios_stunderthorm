//
//  TempTableVC.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/24.
//

import Foundation
import UIKit

class TempTableVC: UIViewController{
    @IBOutlet weak var tableView: UITableView!
    var setScrollEnable : Bool = false{
        willSet(value){
            print(value)
            self.tableView.isScrollEnabled = value
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: TalkTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: TalkTableViewCell.identifier)
    }
}
extension TempTableVC: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TalkTableViewCell.identifier, for: indexPath)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

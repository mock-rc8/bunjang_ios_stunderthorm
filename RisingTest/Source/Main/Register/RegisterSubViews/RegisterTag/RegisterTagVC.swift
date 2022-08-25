//
//  RegisterTagVC.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/25.
//

import Foundation
import UIKit
class RegisterTagVC : UIViewController{
    @IBOutlet weak var tableView: UITableView!
    static let identifier = "RegisterTagVC"
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: RegisterCategoryTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: RegisterCategoryTableViewCell.identifier)
    }
}

extension RegisterTagVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RegisterCategoryTableViewCell.identifier) as! RegisterCategoryTableViewCell
        
        return cell
        
    }
    
    
}

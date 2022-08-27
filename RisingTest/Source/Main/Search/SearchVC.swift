//
//  File.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/27.
//

import Foundation
import UIKit
class SearchVC:UIViewController{
    static let identifer = "SearchVC"
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationSettings()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = true
    }

}
//MARK: -- Navigation Bar Settings
extension SearchVC{
    func navigationSettings(){
        let searchBar = UISearchBar()
        searchBar.placeholder = "검색어를 입력해주세요"
        self.navigationItem.titleView = searchBar
        self.navigationItem.leftBarButtonItem = {
            let item = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(self.closeView))
            item.image = UIImage(systemName: "chevron.left")
            item.tintColor = .black
            return item
        }()
        self.view.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = {
            let item = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(searchView))
            item.image = UIImage(systemName: "house")
            item.tintColor = .black
            return item
        }()
    }
    @objc func closeView(){
        _ = self.navigationController?.popViewController(animated: true)
    }
    @objc func searchView(){
        self.navigationController?.popToRootViewController(animated: true)
    }
    @objc func shareView(){
        print("공유 구현 해야한다.")
    }
}

//
//  ItemVC.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/24.
//

import Foundation
import UIKit
import PanModal
class ItemVC: UIViewController{
    static let identifer = "ItemVC"
    @IBOutlet weak var shopCollectionView: UICollectionView!
    @IBOutlet weak var shopCollectionHeight: NSLayoutConstraint!
    @IBOutlet weak var adCollectionView: UICollectionView!
    @IBOutlet weak var adCollectionHeight: NSLayoutConstraint!
    lazy var itemShopManager = ItemShopManager(data:["Hello","","","","",""])
    lazy var adShopManager = AdShopManager(data:AdShopData.shared.adData)
    override func viewDidLoad() {
        super.viewDidLoad()
        shopCollectionSettings()
        adCollectionSettings()
        self.navigationSettings()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    override func viewDidAppear(_ animated: Bool) {
        let height = self.adCollectionView.collectionViewLayout.collectionViewContentSize.height
        self.adCollectionHeight.constant = height
    }
    
    //MARK: -- NavigationItem Settings
    func navigationSettings(){
        self.navigationItem.leftBarButtonItem = {
            let item = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(self.closeView))
            item.image = UIImage(systemName: "chevron.left")
            item.tintColor = .black
            return item
        }()
        self.view.backgroundColor = .white
        self.navigationItem.rightBarButtonItems = [{
            let item = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(shareView))
            item.image = UIImage(systemName: "square.and.arrow.up")
            item.tintColor = .black
            return item
        }(),{
            let item = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(searchView))
            item.image = UIImage(systemName: "magnifyingglass")
            item.tintColor = .black
            return item
        }()]
    }
    @objc func closeView(){
        _ = self.navigationController?.popViewController(animated: true)
    }
    @objc func searchView(){
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: SearchVC.identifer) as! SearchVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func shareView(){
        print("공유 구현 해야한다.")
    }
    @IBAction func talkBtnAction(_ sender: UIButton) {
    }
    @IBAction func safePayBtnAction(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: SafePayModalVC.identifier) as! SafePayModalVC
        presentPanModal(vc)
    }
    //MARK: -- 이 상점의 상품 콜렉션
    func shopCollectionSettings(){
        self.itemShopManager.heightMethod = { height in self.shopCollectionHeight.constant = height*2}
        self.shopCollectionView.register(UINib(nibName: ItemShopCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: ItemShopCollectionViewCell.identifier)
        self.shopCollectionView.delegate = itemShopManager
        self.shopCollectionView.dataSource = itemShopManager
        self.shopCollectionView.collectionViewLayout = ItemShopManager.createCompositionalLayout()
        self.shopCollectionView.register(UINib(nibName: CategoryCollectionReusableView.identifier, bundle: nil), forSupplementaryViewOfKind: "myHeader", withReuseIdentifier: CategoryCollectionReusableView.identifier)
        
        self.shopCollectionView.backgroundColor = UIColor.cyan
    }
    //MARK: -- 파워쇼핑, 이 상품과 비슷해요 컬렉션
    func adCollectionSettings(){
        self.adCollectionView.register(UINib(nibName: ItemShopCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: ItemShopCollectionViewCell.identifier)
        self.adCollectionView.register(UINib(nibName: AdShopCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: AdShopCollectionViewCell.identifier)
        self.adCollectionView.register(UINib(nibName: ItemHeaderCollectionReusableView.identifier, bundle: nil), forSupplementaryViewOfKind: "header", withReuseIdentifier: ItemHeaderCollectionReusableView.identifier)
        self.adCollectionView.delegate = adShopManager
        self.adCollectionView.dataSource = adShopManager
        self.adCollectionView.collectionViewLayout = AdShopManager.createCompositionalLayout()
    }
}

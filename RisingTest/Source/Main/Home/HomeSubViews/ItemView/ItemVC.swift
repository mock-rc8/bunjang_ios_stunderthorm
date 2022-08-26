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
        self.tabBarController?.tabBar.isHidden = true
        shopCollectionSettings()
        adCollectionSettings()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidAppear(_ animated: Bool) {
        let height = self.adCollectionView.collectionViewLayout.collectionViewContentSize.height
        self.adCollectionHeight.constant = height
    }
    @IBAction func talkBtnAction(_ sender: UIButton) {
    }
    @IBAction func safePayBtnAction(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: SafePayModalVC.identifier) as! SafePayModalVC
        presentPanModal(vc)
    }
    func shopCollectionSettings(){
        self.itemShopManager.heightMethod = { height in self.shopCollectionHeight.constant = height*2}
        self.shopCollectionView.register(UINib(nibName: ItemShopCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: ItemShopCollectionViewCell.identifier)
        self.shopCollectionView.delegate = itemShopManager
        self.shopCollectionView.dataSource = itemShopManager
        self.shopCollectionView.collectionViewLayout = ItemShopManager.createCompositionalLayout()
        self.shopCollectionView.backgroundColor = UIColor.cyan
    }
    func adCollectionSettings(){
        self.adCollectionView.register(UINib(nibName: ItemShopCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: ItemShopCollectionViewCell.identifier)
        self.adCollectionView.register(UINib(nibName: AdShopCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: AdShopCollectionViewCell.identifier)
        self.adCollectionView.register(UINib(nibName: ItemHeaderCollectionReusableView.identifier, bundle: nil), forSupplementaryViewOfKind: "header", withReuseIdentifier: ItemHeaderCollectionReusableView.identifier)
        self.adCollectionView.delegate = adShopManager
        self.adCollectionView.dataSource = adShopManager
        self.adCollectionView.collectionViewLayout = AdShopManager.createCompositionalLayout()
    }
}

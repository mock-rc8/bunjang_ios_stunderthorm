//
//  MyHeaderCollectionReusableView.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/29.
//

import UIKit

class MyHeaderCollectionReusableView: UICollectionReusableView {
    @IBOutlet weak var numberCollection: UICollectionView!
    @IBOutlet weak var shopInfoCollection: UICollectionView!
    @IBOutlet weak var headerWrapper: UIStackView!
    @IBOutlet weak var headerTitle: UILabel!
    var myIdx = 0
    var myVC : UIViewController?
    static let identifier = "MyHeaderCollectionReusableView"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.headerTitle.text = Variable.USER_NAME
    }
    
    @IBAction func myStoreBtnAction(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyStoreVC") as! MyStoreVC
        self.myVC?.navigationController?.pushViewController(vc, animated: true)
    }
}

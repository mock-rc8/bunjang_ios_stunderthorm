//
//  SearchFooterCollectionReusableView.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/29.
//

import UIKit

class SearchFooterCollectionReusableView: UICollectionReusableView {
    @IBOutlet weak var btnView: UIButton!
    var btnAction : (()->(Void))?
    static let identifier = "SearchFooterCollectionReusableView"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func btnAction(_ sender: UIButton) {
        if let act = btnAction{
            act()
        }
    }
    
}

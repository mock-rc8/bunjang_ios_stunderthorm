//
//  BrandAppendHeader.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/30.
//

import UIKit

class BrandAppendHeader: UICollectionReusableView {
static let identifier = "BrandAppendHeader"
    var myVC :UIViewController?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func brandAppendBtnAction(_ sender: UIButton) {
        let vc = UIStoryboard(name: "EntireMenuStoryboard", bundle: nil).instantiateViewController(withIdentifier: BrandEntireVC.identifier) as! BrandEntireVC
        vc.isHomeCalled = true
        myVC?.navigationController?.pushViewController(vc, animated: true)
    }
    
}

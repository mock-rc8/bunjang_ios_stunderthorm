//
//  BHScrollCollectionViewCell.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/30.
//

import UIKit

class BHScrollCollectionViewCell: UICollectionViewCell {
    //@IBOutlet weak var settingLabel: BasePaddingLabel!
    
    @IBOutlet weak var scrollBtn: UIButton!
    static let identifier = "BHScrollCollectionViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setFrameStyle(_ isCheck: Bool){
        if isCheck{
            self.backgroundColor = .black
            //settingLabel.textColor = .white
        }else{
            self.backgroundColor = .white
            //settingLabel.textColor = .black
        }
    }
}

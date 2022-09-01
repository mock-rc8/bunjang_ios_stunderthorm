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
        var fonnt = UIFont(name: "System", size: 18)
        fonnt = .systemFont(ofSize: 18, weight: .bold)
        self.scrollBtn.titleLabel?.font = fonnt
        
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

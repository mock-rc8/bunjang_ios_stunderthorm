//
//  RecentSearchCollectionViewCell.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/29.
//

import UIKit

class RecentSearchCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var myTitleLabel: PaddingLabel!
    @IBOutlet weak var btn: UIButton!
    static let identifier = "RecentSearchCollectionViewCell"
    var myNumber = -1
    var myIndexPath :IndexPath?
    var myKey: Key?
    var closeBtnAction : ((_ myKey:Key,_ myIdxPath: IndexPath)->())?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
    }

    @IBAction func deleteBtn(_ sender: Any) {
        if let closeBtn = self.closeBtnAction, let idxPath = self.myIndexPath{
            closeBtn(myKey!,idxPath)
        }
        
    }
    func setCornerRadius(_ num:CGFloat){
        self.layer.cornerRadius = num
    }
}

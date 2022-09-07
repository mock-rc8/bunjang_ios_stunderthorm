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
    var labelAction : ((_ text:String)->())?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
        let tap = UITapGestureRecognizer(target: self, action: #selector(labelTap))
        myTitleLabel.addGestureRecognizer(tap)
    }
    @objc func labelTap(){
        if let labelAct = labelAction{
            labelAct(self.myTitleLabel.text ?? "")
        }
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

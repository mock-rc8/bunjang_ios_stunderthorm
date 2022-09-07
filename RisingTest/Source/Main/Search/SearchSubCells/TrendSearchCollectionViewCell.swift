//
//  TrendSearchCollectionViewCell.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/29.
//

import UIKit

class TrendSearchCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var bellBtn: UIButton!
    static let identifier = "TrendSearchCollectionViewCell"
    var tapDelegate : ((_ text : String)->(Void))?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bellBtn.layer.cornerRadius = bellBtn.layer.frame.height / 2
        let tap = UITapGestureRecognizer(target: self, action: #selector(myTap))
        self.addGestureRecognizer(tap)
        self.layer.borderColor = UIColor.systemGray3.cgColor
        self.layer.borderWidth = 1
    }
    @objc func myTap(){
        if let tapped = self.tapDelegate{
            tapped(self.productLabel.text ?? "")
        }
    }
}

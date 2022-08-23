//
//  OnBoardCollectionViewCell.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/21.
//

import UIKit

class OnBoardCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
//        self.titleLabel.numberOfLines = 0
//        self.titleLabel.backgroundColor = .white
//        self.titleLabel.textColor = .black
//        self.titleLabel.sizeToFit()
        self.titleLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        
    }
    func setData(){
        //self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.numberOfLines = 0
        self.titleLabel.backgroundColor = .white
        self.titleLabel.textColor = .black
        self.titleLabel.sizeToFit()
        self.titleLabel.font = .systemFont(ofSize: 32, weight: .bold)
    }
}

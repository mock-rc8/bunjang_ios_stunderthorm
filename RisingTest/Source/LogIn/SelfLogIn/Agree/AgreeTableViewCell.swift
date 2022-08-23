//
//  AgreeTableViewCell.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/23.
//

import UIKit

class AgreeTableViewCell: UITableViewCell {
    @IBOutlet weak var checkImgView: UIImageView!
    static let identifier = "AgreeTableViewCell"
    @IBOutlet weak var AgreeLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    @IBAction func downBtnAction(_ sender: UIButton) {
        print("hello world!!")
    }
    func setStatus(_ data:AgreeData){
        self.checkImgView.tintColor = data.isChecked ? .red : .gray
        self.AgreeLabel.text = data.agreeTitle
        self.statusLabel.text = data.agreeStatus.rawValue
    }
}

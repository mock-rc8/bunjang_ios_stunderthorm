//
//  ServiceEntireTableViewCell.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/26.
//

import UIKit

class ServiceEntireTableViewCell: UITableViewCell {
static let identifier = "ServiceEntireTableViewCell"
    @IBOutlet weak var eventLabel: UIButton!
    @IBOutlet weak var myimageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

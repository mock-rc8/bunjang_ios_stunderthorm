//
//  RegisterCategoryTableViewCell.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/25.
//

import UIKit

class RegisterCategoryTableViewCell: UITableViewCell {
static let identifier = "RegisterCategoryTableViewCell"
    @IBOutlet weak var titleLabel: UILabel!
    var isHaveNext :Bool = false
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setAccessData(_ flag: Bool){
        if flag == true{
            self.accessoryType = .disclosureIndicator
        }else{
            self.accessoryType = .none
        }
        
    }
}

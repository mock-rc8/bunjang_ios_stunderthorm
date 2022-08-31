//
//  AlertSettingCell.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/31.
//

import UIKit
import OrderedCollections
class AlertSettingCell: UITableViewCell {
    @IBOutlet weak var switcher: UISwitch!
    @IBOutlet weak var titleLabel: UILabel!
    var sectionIdx = -1
    var itemIdx = -1
    var isOnAct : ((_ isOn:Bool)->())?
    static let identifier = "AlertSettingCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func switcherAction(_ sender: Any) {
        self.isOnAct!(self.switcher.isOn)
    }
}

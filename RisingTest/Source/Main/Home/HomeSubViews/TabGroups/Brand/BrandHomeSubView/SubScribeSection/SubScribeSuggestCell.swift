//
//  SubScribeSuggestCell.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/30.
//

import UIKit

class SubScribeSuggestCell: UICollectionViewCell {
    @IBOutlet weak var titleImg: UIImageView!
    @IBOutlet weak var safePayImg: UIImageView!
    @IBOutlet weak var heartBtn: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var loactionLabel: UILabel!
    @IBOutlet weak var uploadDateLabel: UILabel!
    static let identifier = "SubScribeSuggestCell"
    var myData : CategoryResult?
    var myParentVC: UIViewController?
    var pushDelegate: ((_ idx: Int)->())?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let tap = UITapGestureRecognizer(target: self, action: #selector(nextAction))
        self.addGestureRecognizer(tap)
    }
    @objc func nextAction(){
        if let del = pushDelegate{
            del(self.myData!.postIdx)
        }
    }
    func setData(_ data: CategoryResult){
        self.myData = data
        self.priceLabel.text = Variable.getMoneyFormat(data.price)
        self.titleLabel.text = data.postTitle
        self.safePayImg.isHidden = !data.payStatus
    }
    @IBAction func heartBtnAction(_ sender: UIButton) {
        self.myData?.zzimStatus.toggle()
        self.setZzimStyle()
        NotificationCenter.default.post(name: self.myData!.zzimStatus ? Notification.Name.ZzimOn : Notification.Name.ZzimOff, object: nil)
    }
    func setZzimStyle(){
        self.heartBtn.tintColor = self.myData!.zzimStatus ? .systemPink : .systemGray2
        let image = UIImage(systemName: self.myData!.zzimStatus ? "heart.fill" : "heart" ,withConfiguration: UIImage.SymbolConfiguration(pointSize: 18,weight: .bold,scale: .large))
        self.heartBtn.setImage(image, for: .normal)   
    }
}

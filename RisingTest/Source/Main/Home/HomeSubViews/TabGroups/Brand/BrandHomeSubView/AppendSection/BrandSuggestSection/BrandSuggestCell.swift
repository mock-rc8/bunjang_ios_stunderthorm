//
//  BrandSuggestCell.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/30.
//

import UIKit

class BrandSuggestCell: UICollectionViewCell {
    static let identifier = "BrandSuggestCell"
    @IBOutlet weak var titleImgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var safePayView: UIImageView!
    @IBOutlet weak var AD_View: UILabel!
    @IBOutlet weak var heartBtn: UIButton!
    var myPostIdx : Int?
    var isMyZzim : Bool?
    var parentVC: UIViewController?
    var zzimData = ZzimDataManager()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setData(_ data: CategoryResult){
        self.titleLabel.text = data.postTitle
        self.priceLabel.text = Variable.getMoneyFormat(data.price)
        self.safePayView.isHidden = !data.payStatus
        self.isMyZzim = data.zzimStatus
        self.myPostIdx = data.postIdx
        self.setZzimStyle()
    }
    func setData(_ data: SearchReResult){
        self.titleLabel.text = data.postTitle
        self.priceLabel.text = Variable.getMoneyFormat(data.price)
        self.safePayView.isHidden = !data.payStatus
        self.AD_View.isHidden = true
        self.isMyZzim = data.zzimStatus
        self.myPostIdx = data.postIdx
        self.setZzimStyle()
    }
    @IBAction func heartBtnAction(_ sender: UIButton) {
        self.isMyZzim?.toggle()
        self.setZzimStyle()
        if self.isMyZzim!{
            zzimData.zzimOn(self.myPostIdx!, delegate: self)
        }else{
            zzimData.zzimOff(self.myPostIdx!, delegate: self)
        }
        NotificationCenter.default.post(name: self.isMyZzim! ? Notification.Name.ZzimOn : Notification.Name.ZzimOff, object: nil)
    }
    func setZzimStyle(){
        self.heartBtn.tintColor = self.isMyZzim! ? .systemPink : .white
        let image = UIImage(systemName: self.isMyZzim! ? "heart.fill" : "heart" ,withConfiguration: UIImage.SymbolConfiguration(pointSize: 18,weight: .bold,scale: .large))
        self.heartBtn.setImage(image, for: .normal)
    }
}
extension BrandSuggestCell:ZzimProtocol{
    func didSuccessZZimOn() {
        print("찜 대성공")
    }
    
    func didSuccessZzimOff() {
        print("찜 대 OFF")
    }
    
    func failedToRequest(message: String) {
        print("찜 초 대 실패")
    }
    
    
}

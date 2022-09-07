//
//  RecommendCollectionViewCell.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/24.
//

import UIKit
import Kingfisher
class RecommendCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var headImgView: UIImageView!
    @IBOutlet weak var safePayView: UIImageView!
    @IBOutlet weak var heartBtn: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var uploadDateLabel: UILabel!
    @IBOutlet weak var likesBtn: UIButton!
    static let identifier = "RecommendCollectionViewCell"
    var myPostIdx: Int = -1
    var myData : RecommendResult?
    var tapDelegate : ((_ postIdx:Int)->())?
    var myParentVC: UIViewController?
    lazy var zzimDataManager = ZzimDataManager()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let tap = UITapGestureRecognizer(target: self, action: #selector(cellTap))
        self.addGestureRecognizer(tap)
    }
    @objc func cellTap(){
        if let tapped = tapDelegate{
            tapped(self.myData!.postIdx)
        }
    }
    func setData(_ data: RecommendResult){
        self.myData = data
        self.safePayView.isHidden = data.payStatus
        self.setZzimStyle()
        self.priceLabel.text = Variable.getMoneyFormat(data.price)
        self.titleLabel.text = data.postTitle
        self.locationLabel.text = data.tradeRegion ?? "지역정보 없음"
        self.uploadDateLabel.text = data.postingTime
        self.myPostIdx = data.postIdx
        likesBtn.setTitle("\(data.likeNum)", for: .normal)
    }
    @IBAction func zzimBtnAction(_ sender: UIButton) {
        self.myData?.zzimStatus.toggle()
        self.setZzimStyle()
        if self.myData!.zzimStatus{
            self.zzimDataManager.zzimOn(self.myPostIdx, delegate: self)
        }else{
            self.zzimDataManager.zzimOff(self.myPostIdx, delegate: self)
        }
        NotificationCenter.default.post(name: self.myData!.zzimStatus ? Notification.Name.ZzimOn : Notification.Name.ZzimOff, object: nil)
    }
    func setZzimStyle(){
        self.heartBtn.tintColor = self.myData!.zzimStatus ? .systemPink : .white
        let image = UIImage(systemName: self.myData!.zzimStatus ? "heart.fill" : "heart" ,withConfiguration: UIImage.SymbolConfiguration(pointSize: 18,weight: .bold,scale: .large))
        self.heartBtn.setImage(image, for: .normal)
    }
}


extension RecommendCollectionViewCell:ZzimProtocol{
    func didSuccessZZimOn() {
        print("찜 성공")
    }
    
    func didSuccessZzimOff() {
        print("찜 끄기")
    }
    
    func failedToRequest(message: String) {
        print("찜 대실패")
    }
    
    
}

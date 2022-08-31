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
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setData(_ data: RecommendResult){
//            if let imgURL = data.postImg_url{
//                DispatchQueue.main.async {
//                    self.headImgView.kf.setImage(with: URL(string: imgURL))
//                }
//            }else
//        {
//                self.headImgView.image = UIImage(named: "onboard1")
//            }
        self.safePayView.isHidden = data.payStatus
        self.setHeartStyle(data.zzimStatus)
        self.priceLabel.text = "\(data.price)원"
        self.titleLabel.text = data.postTitle
        self.locationLabel.text = data.tradeRegion ?? "지역정보 없음"
        self.uploadDateLabel.text = data.postingTime
        self.myPostIdx = data.postIdx
        likesBtn.setTitle("\(data.likeNum)", for: .normal)
    }
    func setHeartStyle(_ likes: Bool){
        self.heartBtn.setImage(UIImage(systemName: likes ? "heart.fill" : "heart"), for: .normal)
    }
}

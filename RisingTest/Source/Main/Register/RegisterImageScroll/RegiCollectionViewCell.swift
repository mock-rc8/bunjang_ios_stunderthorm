//
//  RegiCollectionViewCell.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/28.
//

import UIKit
import Photos
class RegiCollectionViewCell: UICollectionViewCell {
static let identifier = "RegiCollectionViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    @IBAction func pictureTouchBtn(_ sender: UIButton) {
        PHPhotoLibrary.requestAuthorization{ status in
            print("라이브러리 접근 시도")
//                   if status == .authorized{//저장
//                       PHPhotoLibrary.shared().performChanges({PHAssetChangeRequest.creationRequestForAsset(from: image)}, completionHandler: {
//                           (success, error) in
//                           print("---> 이미지 저장완료 했나? \(success)")
//                       })
//                       }else{
//                       print("---> 권한을 아직 받지 못함.")
//                   }
           
               }

    }
    
}

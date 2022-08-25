//
//  HomeTitleLabel.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/24.
//

import Foundation
import UIKit
class HomeLabel: UILabel{
    //padding 설정
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 0)
        super.drawText(in: rect.inset(by: insets))
    }
    //padding 때문에 넘어가는 영역 설정
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width+40, height: size.height + 40)
    }
}

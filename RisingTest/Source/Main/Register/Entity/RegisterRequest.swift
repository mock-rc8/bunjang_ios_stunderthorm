//
//  RegisterRequest.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/23.
//

import Foundation

struct RegisterRequest: Encodable {
    var postImg_url: [String]
    var tradeRegion: String
    var postTitle: String
    var categoryIdx: Int
    var hashTagName: [String]
    var price: Int
    var deliveryFee: String
    var quantity: Int
    var prodStatus: String
    var exchange: String
    var payStatus: String
}

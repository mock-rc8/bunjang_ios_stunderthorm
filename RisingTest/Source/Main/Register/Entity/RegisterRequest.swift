//
//  RegisterRequest.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/23.
//

import Foundation

struct RegisterRequest: Encodable {
    let postImg_url : [String]
    let tradeRegion : String
    let postTitle : String
    let postContent : String
    let categoryIdx : Int
    let hashTagName : [String]
    let price : Int
    let deliveryFee : String
    let quantity : Int
    let prodStatus : String
    let exchange : String
    let payStatus : String
}

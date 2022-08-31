//
//  BrandEntity.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/31.
//

import Foundation
struct BrandEntireResponse:Decodable{
    var isSuccess: Bool
    var code : Int
    var message: String
    var result: [BrandEntireResult]?
}

struct BrandEntireResult: Decodable{
    var brandIdx: Int
    var brandImg_url: String
    var brandName: String
    var brandEngName: String
    var postNum: Int
}
// app/brands/order/kor

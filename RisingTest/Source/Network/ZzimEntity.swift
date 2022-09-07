//
//  ZzimEntity.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/09/06.
//

import Foundation
struct ZzimRequest: Encodable {
    var userName: String
    var phoneNumber: Int
    var birth: Int
}
struct ZzimResponse: Decodable {
    var code: Int
    var message: String
    var isSuccess: Bool
    var result: String?
}

struct ZzimAllResponse: Decodable{
    var code: Int
    var message: String
    var isSuccess: Bool
    var result: [ZzimResult]?
}
struct ZzimResult:Decodable{
    var postImg_url : String?
    var postIdx: Int
    var price: Int
    var userName: String
    var createdAt: String
}

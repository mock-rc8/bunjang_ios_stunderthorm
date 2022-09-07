//
//  HashTagEntitu.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/09/07.
//

import Foundation
struct HashTagResponse: Decodable {
    var code: Int
    var message: String
    var isSuccess: Bool
    var result: [HashTagResult]?
}
struct HashTagResult: Decodable{
    var postIdx: Int
    var hashTagName: String
}

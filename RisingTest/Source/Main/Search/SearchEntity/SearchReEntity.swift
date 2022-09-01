//
//  SearchEntity.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/09/02.
//

import Foundation

struct SearchReResponse:Decodable{
    var isSuccess: Bool
    var code : Int
    var message: String
    var result: [SearchReResult]?
}

struct SearchReResult: Decodable{
    var postIdx: Int
    var postImg_url : String
    var zzimStatus: Bool
    var price: Int
    var postTitle: String
    var payStatus: Bool
    var sellingStatus: String?
}


//
//  CategoryEntity.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/31.
//

struct CategoryResponse:Decodable{
    var isSuccess: Bool
    var code : Int
    var message: String
    var result: [CategoryResult]?
}

struct CategoryResult: Decodable{
    var postIdx: Int
    var postImg_url : String
    var zzimStatus: Bool
    var price: Int
    var postTitle: String
    var payStatus: Bool
}

//
//  HomeRecommendEntity.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/28.
//

import Foundation
struct RecommendResult: Decodable{
    var postIdx: Int
    var postImg_url: String?
    var zzimStatus: Bool
    var price: Int
    var postTitle: String
    var tradeRegion: String?
    var postingTime: String
    var payStatus: Bool
    var likeNum: Int
    var sellingStatus: String
}
struct RecommendResponse: Decodable {
    var isSuccess: Bool
    var code : Int
    var message: String
    var result: [RecommendResult]?
}

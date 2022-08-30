//
//  ItemEntity.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/30.
//

import Foundation
struct ItemResponse:Decodable{
    var isSuccess: Bool
    var code : Int
    var message: String
    var result: ItemResult
}

struct ItemResult: Decodable{
    var postIdx : Int
    var price : Int
    var payStatus : Bool
    var postTitle: String
    var tradeRegion: String
    var postingTime: String
    var viewNum: Int
    var likeNum:Int
    var chatNum:Int
    var prodStatus:String
    var quantity:Int
    var deliveryFee:String
    var exchange:String
    var postContent:String
    var sellingStatus:String
    var zzimStatus:Bool
}

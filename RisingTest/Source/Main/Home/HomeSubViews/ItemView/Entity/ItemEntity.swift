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
    var result: ItemResult?
}

struct ItemResult: Decodable{
    var postIdx : Int // ?
    var price : Int // O o
    var payStatus : Bool // O o
    var postTitle: String // O o
    var tradeRegion: String? // O o
    var postingTime: String // O o
    var viewNum: Int // O o
    var likeNum:Int // O o
    var chatNum:Int // O o
    var prodStatus:String // O o
    var quantity:Int // O o
    var deliveryFee:String // O ??
    var exchange:String // O o
    var postContent:String // O o
    var sellingStatus:String // ?
    var zzimStatus:Bool // 아직 구현 못 함
}
struct ItemImgResponse:Decodable{
    var isSuccess: Bool
    var code : Int
    var message: String
    var result: [ItemImgResult]?

}
struct ItemImgResult:Decodable{
    var postIdx :Int
    var postImg_url : String
}

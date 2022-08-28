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
enum ProdStatus:String{
    case used = "중고상품"
    case new = "새상품"
}
enum PayStatus: String{
    case safe = "Y"
    case unsafe = "N"
}
struct RegisterData{
    var postImg_url : [String] = [] // X
    var tradeRegion : String = "" // O => 전송 시 Variable.USER_LOCATION
    var postTitle : String = "" // O => 전송 시
    var postContent : String = "" // O => 전송 시
    var categoryIdx : Int = -1 // O => -1 이면 에러
    var hashTagName : [String] = [] // X
    var price : Int = 0 // O
    var deliveryFee : Bool = false // O
    var quantity : Int = 1 // O
    var prodStatus : ProdStatus = .used // O
    var exchange : Bool = false // O
    var payStatus : PayStatus = .unsafe // O
    public func changeRequestData()->RegisterRequest{
        return RegisterRequest(postImg_url: self.postImg_url, tradeRegion: self.tradeRegion, postTitle: self.postTitle, postContent: self.postContent, categoryIdx: self.categoryIdx, hashTagName: self.hashTagName, price: self.price, deliveryFee: self.deliveryFee ? "Y":"N", quantity: self.quantity, prodStatus: self.prodStatus.rawValue, exchange: self.exchange ? "가능":"불가", payStatus: self.payStatus.rawValue)
    }
}

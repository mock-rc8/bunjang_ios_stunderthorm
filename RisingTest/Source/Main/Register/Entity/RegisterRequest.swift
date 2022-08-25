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
    var postImg_url : [String] = []
    var tradeRegion : String = ""
    var postTitle : String = ""
    var postContent : String = ""
    var categoryIdx : Int = 0
    var hashTagName : [String] = []
    var price : Int = 0
    var deliveryFee : Bool = false
    var quantity : Int = 0
    var prodStatus : ProdStatus = .used
    var exchange : Bool = false
    var payStatus : PayStatus = .unsafe
}

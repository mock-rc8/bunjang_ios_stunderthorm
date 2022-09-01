//
//  MyEntity.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/09/01.
//

import Foundation
struct MyResponse:Decodable{
    var isSuccess: Bool
    var code : Int
    var message: String
    var result: MyResult?
}

struct MyResult: Decodable{
    var userName : String
    var profileImg_url: String?
    var zzim_num : Int
    var review_num : Int
    var follower_num : Int
    var following_num : Int
    var postMyPages : [PostMyPages]?
}
struct PostMyPages: Decodable{
    var postImg_url: String
    var postIdx: Int
    var postTitle: String
    var price: Int
    var postUserName: String
}

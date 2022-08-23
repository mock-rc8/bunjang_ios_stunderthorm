//
//  SignInRequest.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/23.
//
struct SignInRequest: Encodable {
    var name: String
    var telephone: Int
    var birth: Int
}
struct SignInResponse: Decodable {
    var code: Int
    var message: String
    var isSuccess: Bool
    var result: SignInResult?
}

struct SignInResult: Decodable {
    var token: String
    var userInfoIdx: Int
}



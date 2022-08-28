//
//  SignInRequest.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/23.
//
struct SignInRequest: Encodable {
    var userName: String
    var phoneNumber: Int
    var birth: Int
}
struct SignInResponse: Decodable {
    var code: Int
    var message: String
    var isSuccess: Bool
    var result: SignInResult?
}

struct SignInResult: Decodable {
    var userIdx: Int
}



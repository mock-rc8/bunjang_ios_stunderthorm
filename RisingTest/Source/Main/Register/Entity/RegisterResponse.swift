//
//  RegisterResponse.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/23.
//

struct RegisterResponse: Decodable {
    var isSuccess: Bool
    var code : Int
    var message: String
    var result: RegisterResult?
}

struct RegisterResult: Decodable {
    var postIdx: Int
}

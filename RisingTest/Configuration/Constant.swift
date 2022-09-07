//
//  Constant.swift
//  EduTemplate - storyboard
//
//  Created by Zero Yoon on 2022/02/23.
//

import Alamofire
import Foundation
struct Constant {
    static let BASE_URL = "https://mingyudev.shop"
    //static let KOBIS_BASE_URL = "http://www.kobis.or.kr/kobisopenapi/webservice/rest"
    static let REGISTER = "/new"
    static let SIGN_UP = "/app/users/sign-up"
    static let POST = "/app/posts"
    static let BRAND_ALL = "/app/brands/order/kor"
    static let MY_PAGE = "/app/my-page"
    //
}
struct Variable{
    static var USER_ID = 13
    static var USER_LOCATION = "뉴욕시 맨해튼구"
    static var USER_PHONE = "01012345678"
    static var USER_NAME = "구음"
    static func getUser_Phone(_ myNumber:String)->(first:String,second:String,third:String){
        print(myNumber)
        let last = myNumber.index(myNumber.startIndex, offsetBy: 3)
        let first:String = String(myNumber[myNumber.startIndex..<last])
        let temp = myNumber.index(last,offsetBy: 4)
        let second:String = String(myNumber[last..<temp])
        let temp2 = myNumber.index(temp,offsetBy: 4)
        let third:String = String(myNumber[temp..<temp2])
        return (first,second,third)
    }
    static var MY_ACCOUNT : [String] = []
    static func getMoneyFormat(_ number: Int) -> String{
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let result = numberFormatter.string(for: number)!
        return "\(result)원"
    }
}
struct Dummy{
    static var SHOP_LIST : [RecommendResult] = []
    static var RECTENT_SEARCH: [String] = []
}

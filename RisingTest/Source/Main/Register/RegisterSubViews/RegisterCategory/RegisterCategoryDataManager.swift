//
//  RegisterCategoryDataManager.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/28.
//

import UIKit
import OrderedCollections
enum ListSection {
    case entire([String])
    case mainCategory([String])
    case subCategory([String])
    
    var items: [String] {
        switch self {
        case .entire(let items),
            .mainCategory(let items),
            .subCategory(let items):
            return items
        }
    }
    
    var count: Int {
        return items.count
    }
    
    var title: String {
        switch self {
        case .entire:
            return "전체"
        case .mainCategory:
            return "Popular"
        case .subCategory:
            return "Coming Soon"
        }
    }
}
struct RegisterCategoryData {
    static let shared = RegisterCategoryData()
    
    private let entire: OrderedDictionary<String,[String]> = ["전체":["여성의류","남성의류","신발","가방","시계/쥬얼리","패션 액세서리","디지털/가전","스포츠/레저","차량/오토바이","스타굿즈","키덜트","예술/희귀/수집품","음반/악기"
                                    ,"도서/티켓/문구","뷰티/미용","가구/인테리어","생활/가공식품","유아동/출산","반려동물용품","기타","지역서비스","원룸/함께살아요"]]
    
    private let mainCategory: OrderedDictionary<String,[String]> = ["여성의류":["자켓,조끼/베스트","셔츠","바지","청바지","패딩/점퍼","블라우스","반바지",
                                                           "정장","트레이닝","티셔츠","치마","원피스","코트","맨투맨","후드티/후드집업","가디건","니트/스웨터","점프수트","언더웨어/홈웨어","테마/이벤트"]]
    
    private let subCategory: OrderedDictionary<String,[String]> = ["바지":["면바지","슬랙스","조거팬츠","레깅스","기타(바지)"]]
    
    var pageData: [OrderedDictionary<String,[String]>] {
        [entire, mainCategory, subCategory]
    }
}

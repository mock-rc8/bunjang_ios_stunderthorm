//
//  SuggestDataManager.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/09/01.
//

import Foundation
import Alamofire
class SuggestCategoryManager{
    func getNewData(myIdx: Int, delegate: SuggestMainCell){
        let urlString: String = "\(Constant.BASE_URL)\(Constant.POST)/\(Variable.USER_ID)/categories/중고거래/\(7)/\(1)"
        let changeString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        print(urlString)
        AF.request(changeString, method: .get).validate().responseDecodable(of:CategoryResponse.self){ response in
            switch response.result {
            case .success(let response):
                // 성공했을 때
                print(response.isSuccess)
                print(response.result)
                print(response.code)
                print(response.message)
                if response.isSuccess, let result:[CategoryResult] = response.result {
                    print("SuggestCategoryManager 성공했습니다")
                    delegate.didSuccessGetItem(result)
                }
                // 실패했을 때
                else {
                    switch response.code {
                    case 2021: delegate.didFailedGetResult(message: "상품 사진을 등록해주세요.")
                    case 2018: delegate.didFailedGetResult(message: "상품명을 2글자 이상 입력해주세요.")
                    case 2019: delegate.didFailedGetResult(message: "카테고리를 선택해주세요.")
                    default: delegate.didFailedGetResult(message: "피드백을 주세요")
                    }
                }
            case .failure(let error):
                print("isFailure")
                print(error.localizedDescription)
                debugPrint(error)
                delegate.didFailedGetResult(message: "서버와의 연결이 원활하지 않습니다")
            }
        }
    }
}
class BrandCategoryManager{
    func getNewData(myIdx: Int, delegate: BrandHomeVC){
        let urlString: String = "\(Constant.BASE_URL)\(Constant.POST)/\(Variable.USER_ID)/categories/중고거래/\(3)/\(1)"
        let changeString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        print(urlString)
        AF.request(changeString, method: .get).validate().responseDecodable(of:CategoryResponse.self){ response in
            switch response.result {
            case .success(let response):
                // 성공했을 때
                print(response.isSuccess)
                print(response.result)
                print(response.code)
                print(response.message)
                if response.isSuccess, let result:[CategoryResult] = response.result {
                    print("SuggestCategoryManager 성공했습니다")
                    delegate.didSuccessGetItem(result)
                }
                // 실패했을 때
                else {
                    switch response.code {
                    case 2021: delegate.didFailedGetResult(message: "상품 사진을 등록해주세요.")
                    case 2018: delegate.didFailedGetResult(message: "상품명을 2글자 이상 입력해주세요.")
                    case 2019: delegate.didFailedGetResult(message: "카테고리를 선택해주세요.")
                    default: delegate.didFailedGetResult(message: "피드백을 주세요")
                    }
                }
            case .failure(let error):
                print("isFailure")
                print(error.localizedDescription)
                debugPrint(error)
                delegate.didFailedGetResult(message: "서버와의 연결이 원활하지 않습니다")
            }
        }
    }
}

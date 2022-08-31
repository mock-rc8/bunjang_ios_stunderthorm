//
//  ItemDataManager.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/30.
//

import Foundation
import Alamofire
class ItemDataManager {
    func getItem(postIdx: Int,delegate: ItemVC) {
        let urlString = "\(Constant.BASE_URL)\(Constant.POST)/\(Variable.USER_ID)/\(postIdx)"
        print(urlString)
        if postIdx == -1{
            delegate.failedGetItem(message: "상품 아이디 오류")
            return
        }
        AF.request(urlString, method: .get).validate().responseDecodable(of:ItemResponse.self){ response in
            switch response.result {
            case .success(let response):
                // 성공했을 때
                print(response.isSuccess)
                print(response.result!)
                print(response.code)
                print(response.message)
                if response.isSuccess, let result = response.result {
                    print("ItemDataManager Success!")
                    print(result)
                    delegate.didSuccessGetItem(result)
                }
                // 실패했을 때
                else {
                    switch response.code {
                    case 4000: delegate.failedGetItem(message: "데이터 연결에 실패했습니다.")
                    default: delegate.failedGetItem(message: "피드백을 주세요")
                    }
                }
            case .failure(let error):
                print("isFailure")
                print(error.localizedDescription)
                debugPrint(error)
                delegate.failedGetItem(message: "서버와의 연결이 원활하지 않습니다")
            }
        }
    }
}

//
//  MyDataManager.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/09/01.
//

import Foundation
import Alamofire
// /app/my-page/:userIdx/:sellingStatus
class MyDataManager {
    func getItem(delegate: MyVC) {
        let urlString = "\(Constant.BASE_URL)\(Constant.MY_PAGE)/\(Variable.USER_ID)/판매중"
        let changeString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        print(urlString)
        AF.request(changeString, method: .get).validate().responseDecodable(of:MyResponse.self){ response in
            switch response.result {
            case .success(let response):
                // 성공했을 때
                print(response.isSuccess)
                print(response.result!)
                print(response.code)
                print(response.message)
                if response.isSuccess, let result = response.result {
                    print("MyDataManager Success!")
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

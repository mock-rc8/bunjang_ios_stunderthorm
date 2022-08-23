//
//  RegisterDataManager.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/23.
//


import Alamofire

class RegisterDataManager {
    func postSignIn(_ parameters: RegisterRequest, delegate: RegiVC) {
        AF.request("\(Constant.BASE_URL)/signin", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: SignInResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess, let result = response.result {
                        delegate.didSuccessSignIn(result)
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        case 2021: delegate.failedToRequest(message: "상품 사진을 등록해주세요.")
                        case 2018: delegate.failedToRequest(message: "상품명을 2글자 이상 입력해주세요.")
                        case 2019: delegate.failedToRequest(message: "카테고리를 선택해주세요.")
                        default: delegate.failedToRequest(message: "피드백을 주세요")
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}

//
//  SignUpDataManager.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/23.
//

import Foundation
import Alamofire
import AuthenticationServices
class SignInDataManager {
    func postSignIn(_ parameters: SignInRequest, delegate: AgreeModalVC) {
        print("post sign in called")
        AF.request("\(Constant.BASE_URL)\(Constant.SIGN_UP)", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
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
                        case 2000: delegate.failedToRequest(message: "상황에 맞는")
                        case 3000: delegate.failedToRequest(message: "에러 메시지로")
                        case 4000: delegate.failedToRequest(message: "데이터베이스 연결에 실패하였습니다.")
                        case 4011: delegate.failedToRequest(message: "비밀번호 암호화에 실패하였습니다.")
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

//
//  ZzimDataManager.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/09/06.
//

import Foundation

import Alamofire
protocol ZzimProtocol{
    func didSuccessZZimOn()
    func didSuccessZzimOff()
    func failedToRequest(message: String)
}
class ZzimDataManager {
    func zzimOn(_ postIdx: Int, delegate: ZzimProtocol) {
        let string = "\(Constant.BASE_URL)/app/zzim/create/\(Variable.USER_ID)/\(postIdx)"
        if true {return}
        AF.request(string, method: .post)
            .validate()
            .responseDecodable(of: ZzimResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess, let result = response.result {
                        print(result)
                        delegate.didSuccessZZimOn()
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
    func zzimOff(_ postIdx: Int, delegate: ZzimProtocol) {
        let string = "\(Constant.BASE_URL)/app/zzim/delete/\(Variable.USER_ID)/\(postIdx)"
        if true {return}
        AF.request(string, method: .patch).validate()
            .responseDecodable(of: ZzimResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess, let result = response.result {
                        print(result)
                        delegate.didSuccessZzimOff()
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
    func getZiimData(delegate: ZzimVC){
        let string = "\(Constant.BASE_URL)/app/my-page/zzim/\(Variable.USER_ID)"
        if true {return}
        AF.request(string, method: .get).validate()
            .responseDecodable(of: ZzimAllResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess, let result = response.result {
                        print(result)
                        delegate.didSuccessGetItem(result)
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

//
//  CategoryDataManager.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/31.
//

import Foundation
import Alamofire
import Kingfisher
import UIKit
class CategoryModel{
    public private(set) var data: [CategoryResult] = []
    public private(set) var dataImgView: [UIImageView] = []
    public private(set) var nowListCount: Int = 0
    private var nowPageCount: Int = 1
    private var totalPage: Int = 100
    private var keyword:String = "cat"
    private var reloadProtocol:ReloadProtocol
    private var myIdx: Int = -1
    init(myIdx: Int,reload:ReloadProtocol){
        self.reloadProtocol = reload
        self.myIdx = myIdx
    }
    public func addMyData() {
        self.getNewData { (data: [CategoryResult]) in
            if(self.nowPageCount <= self.totalPage){
                self.data.append(contentsOf: data)
                let imgViewData = data.map{ (a:CategoryResult) -> UIImageView in
                    let imageView = UIImageView()
                    imageView.kf.setImage(with: URL(string: a.postImg_url))
                    return imageView
                }
                self.dataImgView.append(contentsOf: imgViewData)
                self.nowListCount += data.count
                self.nowPageCount += 1
                self.reloadProtocol.didSuccessGetResult()
                self.reloadProtocol.reload()
            }
        }
    }
}
extension CategoryModel{
    fileprivate func getNewData(onCompleted: @escaping ([CategoryResult])->Void){
        let urlString: String = "\(Constant.BASE_URL)\(Constant.POST)/\(Variable.USER_ID)/categories/중고거래/\(self.myIdx)/\(self.nowPageCount)"
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
                if response.isSuccess, let result = response.result {
                    onCompleted(result)
                }
                // 실패했을 때
                else {
                    switch response.code {
                    case 2021: self.reloadProtocol.didFailedGetResult(message: "상품 사진을 등록해주세요.")
                    case 2018: self.reloadProtocol.didFailedGetResult(message: "상품명을 2글자 이상 입력해주세요.")
                    case 2019: self.reloadProtocol.didFailedGetResult(message: "카테고리를 선택해주세요.")
                    default: self.reloadProtocol.didFailedGetResult(message: "피드백을 주세요")
                    }
                }
            case .failure(let error):
                print("isFailure")
                print(error.localizedDescription)
                debugPrint(error)
                self.reloadProtocol.didFailedGetResult(message: "서버와의 연결이 원활하지 않습니다")
            }
        }
    }
}

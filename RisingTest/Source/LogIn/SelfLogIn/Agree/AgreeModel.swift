//
//  AgreeModel.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/23.
//

import Foundation
import SwiftUI

enum AgreeStatus:String{
    case Require = "(필수)"
    case Choice = "(선택)"
}

struct AgreeData{
    var isChecked : Bool = false
    let agreeTitle : String
    let agreeStatus: AgreeStatus
}

class AgreeDataModel{
    private var data :[AgreeData] = [
        AgreeData(agreeTitle: "번개장터 이용약관", agreeStatus: .Require),
        AgreeData(agreeTitle: "개인정보 수집 이용 동의", agreeStatus: .Require),
        AgreeData(agreeTitle: "휴대폰 본인확인서비스", agreeStatus: .Require),
        AgreeData(agreeTitle: "휴먼 개인정보 분리보관 동의", agreeStatus: .Require),
        AgreeData(agreeTitle: "개인정보 수집 이용 동의", agreeStatus: .Choice),
        AgreeData(agreeTitle: "마케팅 수신 동의", agreeStatus: .Choice)
    ]
    var count:Int{
        get{
            return self.data.count
        }
    }
    var isAllChecked:Bool{
        get{
            return !(self.data.contains { $0.isChecked == false})
        }
    }
    var isReqiuiredAllChecked:Bool{
        get{
            let agreeData = self.data.filter { data in
                return data.agreeStatus == .Require
            }
            return !(agreeData.contains { $0.isChecked == false})
        }
    }
    func getData(_ index: Int)->AgreeData{
        return data[index]
    }
    func setAllDataChecked(){
        for i in 0..<self.data.count{
            self.data[i].isChecked = true
        }
    }
    func setAllDataUnchecked(){
        for i in 0..<self.data.count{
            self.data[i].isChecked = false
        }
    }
    func toggleCheckData(_ index:Int){
        self.data[index].isChecked.toggle()
    }
}

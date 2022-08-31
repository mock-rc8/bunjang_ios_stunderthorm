//
//  EntireSettingData.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/31.
//

enum EntireSettingType:String,CaseIterable{
    case user = "사용자 설정"
    case service = "서비스 정보"
    case logout = "로그아웃"
}
enum UserSettingType:String,CaseIterable{
    case user = "계정 설정"
    case alert = "알림 설정"
    case location = "지역 설정"
    case delivery = "배송지 설정"
    case accoount = "계좌 설정"
    case card = "간편결제 카드 설정"
    case block = "차단 상점 관리"
}
enum ServiceSettingType:String,CaseIterable{
    case tof = "이용약관"
    case userInfo = "개인정보 처리방침"
    case location = "위치기반 서비스 이용약관"
    case version = "버전정보 9.0.2"
}
enum LogoutType: String,CaseIterable{
    case logout = "로그아웃"
}

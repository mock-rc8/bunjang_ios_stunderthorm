//
//  BrandCollectionData.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/30.
//


typealias ScrollData = (type: BrandSecionType,title: String)
enum BrandSecionType{
    case edit
    case brand
    case append
    case appendHeader
}
struct BrandHomeData{
    var sectionType: BrandSecionType
}

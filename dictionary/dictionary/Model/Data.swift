//
//  Data.swift
//  dictionary
//
//  Created by mystic on 2022/06/01.
//

import Foundation

struct Detail: Identifiable {
    var id = UUID()
    var detail_contents : [String : String]
}

struct title : Identifiable {
    var id = UUID()
    var title: String
    var contents: [String]
}

var datas = [
    title(title: "웹",contents: ["백엔드","프론트엔드"]),
    title(title: "모바일",contents: ["네이티브","크로스플랫폼","웹뷰"]),
    title(title: "데이터사이언스", contents: ["AI"]),
    title(title:"게임", contents: ["디자인","에셋"])
]



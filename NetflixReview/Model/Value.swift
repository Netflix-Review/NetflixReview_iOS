//
//  Value.swift
//  NetflixReview
//
//  Created by 강호성 on 2021/09/01.
//

import Foundation

struct Value: Codable {
    let id: Int
    let title: String
    let post: String
    let view: String
    let info: String
    let des: String
    var rank: Int
    var list: Int
}

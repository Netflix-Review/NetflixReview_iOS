//
//  Value.swift
//  NetflixReview
//
//  Created by 강호성 on 2021/09/01.
//

import Foundation

struct Contents: Codable {
    let id: Int
    let title: String
    let post: String
    let view: String
    let info: String
    let des: String
    let rank: Int
}

struct Movie: Codable {
    let id: Int
    let title: String
    let post: String
    let view: String
    let info: String
    let des: String
    let rank: Int
}

struct tvProgram: Codable {
    let id: Int
    let title: String
    let post: String
    let view: String
    let info: String
    let des: String
    let rank: Int
}


//
//  Photo.swift
//  NetflixReview
//
//  Created by 강호성 on 2021/09/01.
//

import Foundation

struct Movie: Codable {
    let title: String
    let image: String
}

struct Photo: Codable {
    let title: String
    let url: String
}

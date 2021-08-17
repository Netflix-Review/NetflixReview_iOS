//
//  HeaderFIlterOptions.swift
//  NetflixReview
//
//  Created by 강호성 on 2021/08/16.
//

import Foundation

enum HeaderFIlterOptions: Int, CaseIterable {
    case Favorite
    case Evaluated
    
    var description: String {
        switch self {
        case .Favorite: return "찜한 작품"
        case .Evaluated: return "평가한 작품"
        }
    }
}

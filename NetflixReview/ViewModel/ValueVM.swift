//
//  ValueVM.swift
//  NetflixReview
//
//  Created by 강호성 on 2021/09/06.
//

import UIKit

struct ValueVM {
    
    var value: Value
    
    var title: String { return value.title }
    var postImageView: URL? { return URL(string: value.post) }
    var backgroundView: URL? { return URL(string: value.view) }
    var info: String { return value.info }
    var desciption: String { return value.des }
    var rank: Int { return value.rank }
    
    init(value: Value) {
        self.value = value
    }
}


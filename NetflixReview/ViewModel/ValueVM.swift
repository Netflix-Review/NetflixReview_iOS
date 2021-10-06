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
    
    
    var ReviewText: NSAttributedString {
        let title = NSMutableAttributedString(string: "리뷰", attributes: [.font: UIFont.boldSystemFont(ofSize: 20),
                                                                         .foregroundColor: UIColor.black])
        
        title.append(NSAttributedString(string: "   2,300개",
                                        attributes: [.font: UIFont.systemFont(ofSize: 15),
                                                     .foregroundColor: UIColor.lightGray]))
        return title
    }
    
    init(value: Value) {
        self.value = value
    }
}


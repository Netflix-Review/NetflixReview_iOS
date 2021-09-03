//
//  ContentsViewModel.swift
//  NetflixReview
//
//  Created by 강호성 on 2021/09/03.
//

import UIKit

struct ContentsViewModel {
    
    var contents: Contents
    
    var contents_title: String { return contents.title }
    var contents_postImageView: URL? { return URL(string: contents.post) }
    
    var ReviewText: NSAttributedString {
        let title = NSMutableAttributedString(string: "리뷰", attributes: [.font: UIFont.boldSystemFont(ofSize: 20)])
        
        title.append(NSAttributedString(string: "   2,300개",
                                        attributes: [.font: UIFont.systemFont(ofSize: 15),
                                                     .foregroundColor: UIColor.lightGray]))
        return title
    }
    
    init(contents: Contents) {
        self.contents = contents
    }
}

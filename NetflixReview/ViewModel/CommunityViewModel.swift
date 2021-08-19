//
//  CommunityViewModel.swift
//  NetflixReview
//
//  Created by 강호성 on 2021/08/17.
//

import UIKit

struct CommunityViewModel {
    
    var CommentText: NSAttributedString {
        let title = NSMutableAttributedString(string: "댓글", attributes: [.font: UIFont.boldSystemFont(ofSize: 20)])
        
        title.append(NSAttributedString(string: "   2,300개",
                                        attributes: [.font: UIFont.systemFont(ofSize: 15),
                                                     .foregroundColor: UIColor.lightGray]))
        return title
    }
    
}

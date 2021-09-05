//
//  PostViewModel.swift
//  NetflixReview
//
//  Created by 강호성 on 2021/08/17.
//

import UIKit

struct MovieViewModel {
    
    var movie: Value
    
    var movie_title: String { return movie.title }
    var movie_postImageView: URL? { return URL(string: movie.post) }
    var movie_backgroundView: URL? { return URL(string: movie.view) }
    var movie_info: String { return movie.info }
    var movie_desciption: String { return movie.des }
    var movie_rank: String { return "\(movie.rank)%" }
    
    
    var ReviewText: NSAttributedString {
        let title = NSMutableAttributedString(string: "리뷰", attributes: [.font: UIFont.boldSystemFont(ofSize: 20)])
        
        title.append(NSAttributedString(string: "   2,300개",
                                        attributes: [.font: UIFont.systemFont(ofSize: 15),
                                                     .foregroundColor: UIColor.lightGray]))
        return title
    }
    
    init(movie: Value) {
        self.movie = movie
    }
}

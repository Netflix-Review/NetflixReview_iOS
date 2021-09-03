//
//  TvProgramViewModel.swift
//  NetflixReview
//
//  Created by 강호성 on 2021/09/03.
//

import UIKit

struct TvProgramViewModel {
    
    var tvProgram: tvProgram
    
    var tvProgram_title: String { return tvProgram.title }
    var tvProgram_postImageView: URL? { return URL(string: tvProgram.post) }
    
    var ReviewText: NSAttributedString {
        let title = NSMutableAttributedString(string: "리뷰", attributes: [.font: UIFont.boldSystemFont(ofSize: 20)])
        
        title.append(NSAttributedString(string: "   2,300개",
                                        attributes: [.font: UIFont.systemFont(ofSize: 15),
                                                     .foregroundColor: UIColor.lightGray]))
        return title
    }
    
    init(tvprogram: tvProgram) {
        self.tvProgram = tvprogram
    }
}

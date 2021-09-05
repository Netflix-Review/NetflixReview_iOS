//
//  TvProgramViewModel.swift
//  NetflixReview
//
//  Created by 강호성 on 2021/09/03.
//

import UIKit

struct TvProgramViewModel {
    
    var tvProgram: Value
    
    var tvProgram_title: String { return tvProgram.title }
    var tvProgram_postImageView: URL? { return URL(string: tvProgram.post) }
    var tvProgram_backgroundView: URL? { return URL(string: tvProgram.view) }
    var tvProgram_info: String { return tvProgram.info }
    var tvProgram_desciption: String { return tvProgram.des }
    var tvProgram_rank: String { return "\(tvProgram.rank)%" }
    
    
    var ReviewText: NSAttributedString {
        let title = NSMutableAttributedString(string: "리뷰", attributes: [.font: UIFont.boldSystemFont(ofSize: 20)])
        
        title.append(NSAttributedString(string: "   2,300개",
                                        attributes: [.font: UIFont.systemFont(ofSize: 15),
                                                     .foregroundColor: UIColor.lightGray]))
        return title
    }
    
    init(tvprogram: Value) {
        self.tvProgram = tvprogram
    }
}

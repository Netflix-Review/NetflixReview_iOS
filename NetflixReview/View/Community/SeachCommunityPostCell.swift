//
//  SeachCommunityPostCell.swift
//  NetflixReview
//
//  Created by 강호성 on 2021/08/19.
//

import UIKit
import SnapKit

class SeachCommunityPostCell: UITableViewCell {
    
    // MARK: - Properties
    
    private let videoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "CommunityPost CommunityPost CommunityPost CommunityPost CommunityPost CommunityPost CommunityPost CommunityPost CommunityPost CommunityPost CommunityPost CommunityPost"
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Helpers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(videoLabel)
        videoLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(10)
            make.trailing.bottom.equalTo(-10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

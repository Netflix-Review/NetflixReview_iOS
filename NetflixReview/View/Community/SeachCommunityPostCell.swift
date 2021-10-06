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
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.text = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Helpers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(videoLabel)
        videoLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(20)
            make.trailing.bottom.equalTo(-20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

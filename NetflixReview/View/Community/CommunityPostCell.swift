//
//  CommunityPostCell.swift
//  NetflixReview
//
//  Created by 강호성 on 2021/08/17.
//

import UIKit
import SnapKit

class CommunityPostCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Another User"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }()
    
    private let commentLabel: UILabel = {
        let label = UILabel()
        label.text = "commentcommentcommentcommentcommentcommentcommentcommentcommentcommentcommentcommentcomment"
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "5일 전"
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    let underlineView = UIView()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configure() {
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(15)
            make.leading.equalTo(16)
        }
        
        // commentLabel이랑 containerView 바닥 맞춰야함 (postLabel길이가 길어지면 넘어감)
        addSubview(commentLabel)
        commentLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.leading.equalTo(nameLabel)
            make.trailing.equalTo(-16)
        }
        
        addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel)
            make.trailing.equalTo(-20)
        }
        
        addSubview(underlineView)
        underlineView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        underlineView.backgroundColor = .systemGroupedBackground
    }
}

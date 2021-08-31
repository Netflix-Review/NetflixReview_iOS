//
//  CommunityCell.swift
//  NetflixReview
//
//  Created by 강호성 on 2021/08/17.
//

import UIKit
import SnapKit

//protocol CommunityCellDelegate: AnyObject {
//    func handleComment()
//}

class CommunityCell: UICollectionViewCell {
    
    // MARK: - Properties
    
//    weak var delegate: CommunityCellDelegate?
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "User"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }()
    
    private let reviewLabel: UILabel = {
        let label = UILabel()
        label.text = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "5일 전"
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
//    private let commentButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("댓글 달기", for: .normal)
//        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
//        button.setTitleColor(.lightGray, for: .normal)
//        button.addTarget(self, action: #selector(handleComment), for: .touchUpInside)
//        return button
//    }()
//
    
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
            make.leading.equalTo(20)
        }
        
        addSubview(reviewLabel)
        reviewLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.leading.equalTo(nameLabel)
            make.trailing.equalTo(-16)
            make.bottom.equalTo(-30)
        }
        
        addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel)
            make.trailing.equalTo(-20)
        }
        
//        addSubview(commentButton)
//        commentButton.snp.makeConstraints { make in
//            make.top.equalTo(reviewLabel.snp.bottom)
//            make.trailing.equalTo(reviewLabel).offset(-10)
//        }
        
    }
    
    // MARK: - Action
    
//    @objc func handleComment() {
//        delegate?.handleComment()
//    }
}

//
//  CommunityPostHeader.swift
//  NetflixReview
//
//  Created by 강호성 on 2021/08/17.
//

import UIKit
import SnapKit

class CommunityPostHeader: UICollectionReusableView {
    
    // MARK: - Properties
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "User"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let postLabel: UILabel = {
        let label = UILabel()
        label.text = "comment comment comment comment comment comment comment comment comment comment comment comment comment comment comment comment comment comment comment comment comment comment comment comment comment comment comment comment comment comment comment comment comment comment"
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
    
    private let bottomLabel: UILabel = {
        let label = UILabel()
        label.text = "댓글"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    let underlineView = UIView()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configureUI() {
//        backgroundColor = .systemBlue
        
        let containerView: UIView = {
            let view = UIView()
            view.backgroundColor = .systemBackground

            view.addSubview(nameLabel)
            nameLabel.snp.makeConstraints { make in
                make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
                make.leading.equalTo(25)
            }
            
            view.addSubview(postLabel)
            postLabel.snp.makeConstraints { make in
                make.top.equalTo(nameLabel.snp.bottom).offset(15)
                make.leading.equalTo(20)
                make.trailing.equalTo(-20)
            }

            view.addSubview(timeLabel)
            timeLabel.snp.makeConstraints { make in
                make.top.equalTo(nameLabel)
                make.trailing.equalTo(-20)
            }
            return view
        }()
        // postLabel이랑 containerView 바닥 맞춰야함 (postLabel길이가 길어지면 넘어감)
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(30)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.height.equalTo(safeAreaLayoutGuide).offset(-100)
        }
        containerView.layer.cornerRadius = 10
        containerView.layer.shadowOpacity = 0.4
        containerView.layer.shadowRadius = 10
        containerView.layer.shadowOffset = .init(width: 0, height: -5)
        containerView.layer.shadowColor = UIColor.lightGray.cgColor
        
        
        addSubview(bottomLabel)
        bottomLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.bottom).offset(10)
            make.leading.equalTo(20)
        }
        
        addSubview(underlineView)
        underlineView.snp.makeConstraints { make in
            make.top.equalTo(bottomLabel.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        underlineView.backgroundColor = .lightGray
    }
    
}

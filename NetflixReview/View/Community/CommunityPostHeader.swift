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
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    private lazy var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground

        view.addSubview(bottomLabel)
        bottomLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(16)
            make.width.equalToSuperview()
            make.height.equalTo(50)
        }

        return view
    }()
    
    private let bottomLabel = UILabel()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        backgroundColor = .systemGroupedBackground
        
        let containerView: UIView = {
            let view = UIView()
            view.backgroundColor = .white

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
        

        addSubview(bottomView)
        bottomView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        bottomView.layer.shadowOpacity = 0.25
        bottomView.layer.shadowRadius = 10
        bottomView.layer.shadowOffset = .init(width: 0, height: -5)
        bottomView.layer.shadowColor = UIColor.lightGray.cgColor
    }
    
    func configureViewModel() {
        let viewModel = CommunityViewModel()
        bottomLabel.attributedText = viewModel.CommentText
    }
    
}

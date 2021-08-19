//
//  CommunityInputAccesoryView.swift
//  NetflixReview
//
//  Created by 강호성 on 2021/08/18.
//

import UIKit

protocol CommunityInputAccesoryViewDelegate: AnyObject {
    func inputView(_ inputView: CommunityInputAccesoryView, uploadComment comment: String)
}

class CommunityInputAccesoryView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: CommunityInputAccesoryViewDelegate?
    
    private let commentTextView: InputTextView = {
        let tv = InputTextView()
        tv.placeholderText = "댓글 달기"
        tv.font = UIFont.systemFont(ofSize: 15)
        tv.isScrollEnabled = false
        return tv
    }()
    
    private let postButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("게시", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(postComment), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // view 자체의 속성만 고려하여 받는 자연스러운 크기
    override var intrinsicContentSize: CGSize {
        return .zero
    }
    
    // MARK: - Action
    
    @objc func postComment() {
        delegate?.inputView(self, uploadComment: commentTextView.text)
    }
    
    // MARK: - Helpers
    
    // 댓글을 게시하고 난 뒤, text 없애기
    func clearCommentTextView() {
        commentTextView.text = nil
        commentTextView.placeholderLabel.isHidden = false
    }
    
    func configureUI() {
        backgroundColor = .white
        autoresizingMask = .flexibleHeight
        
        addSubview(postButton)
        postButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.equalTo(-10)
            make.width.height.equalTo(50)
        }
        
        addSubview(commentTextView)
        commentTextView.snp.makeConstraints { make in
            make.top.equalTo(8)
            make.leading.equalTo(8)
            make.trailing.equalTo(-60)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-8)
        }
        
        let divider = UIView()
        divider.backgroundColor = .lightGray
        addSubview(divider)
        divider.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
    }
    
}

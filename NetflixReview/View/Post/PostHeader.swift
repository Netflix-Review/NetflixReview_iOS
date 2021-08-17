//
//  PostHeader.swift
//  NetflixReview
//
//  Created by 강호성 on 2021/08/16.
//

import UIKit
import SnapKit

protocol PostHeaderDelegate: AnyObject {
    func didTapLike()
    func didTapUnLike()
    func TapWish(_ header: PostHeader)
}

class PostHeader: UICollectionReusableView {
    
    // MARK: - Properties
    
    weak var delegate: PostHeaderDelegate?
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground

        view.addSubview(backgroundImage)
        backgroundImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(250)
        }
        
        backgroundImage.addSubview(wishButton)
        wishButton.snp.makeConstraints { make in
            make.top.equalTo(42)
            make.trailing.equalTo(-20)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        wishButton.layer.cornerRadius = 10
        
        return view
    }()
    
//    private lazy var likeButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setImage(UIImage(systemName: "hand.thumbsup")!, for: .normal)
//        button.layer.borderColor = UIColor.black.cgColor
//        button.layer.borderWidth = 1.25
//        button.tintColor = .black
//        button.backgroundColor = .red.withAlphaComponent(0.5)
//        button.addTarget(self, action: #selector(didTapLike), for: .touchUpInside)
//        return button
//    }()
//
//    private lazy var unlikeButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setImage(UIImage(systemName: "hand.thumbsdown")!, for: .normal)
//        button.layer.borderColor = UIColor.black.cgColor
//        button.layer.borderWidth = 1.25
//        button.tintColor = .black
//        button.backgroundColor = .systemBlue.withAlphaComponent(0.5)
//        button.addTarget(self, action: #selector(didTapUnLike), for: .touchUpInside)
//        return button
//    }()

    private lazy var backgroundImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.image = #imageLiteral(resourceName: "marvel post")
        return iv
    }()
    
    private lazy var wishButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("찜", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemPink
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(TapWish), for: .touchUpInside)
        return button
    }()
    
    private lazy var postImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "marvel")
        return iv
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "어벤져스: 엔드게임"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.text = "영화 ∙ 2019 ∙ 181분"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .lightGray
        return label
    }()
    

    private lazy var textView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground

        view.addSubview(textLabel)
        textLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(16)
            make.width.equalToSuperview()
            make.height.equalTo(50)
        }

        return view
    }()

    private let textLabel = UILabel()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViewModel()
        
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(250)
        }

        addSubview(textView)
        textView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        textView.layer.shadowOpacity = 0.25
        textView.layer.shadowRadius = 10
        textView.layer.shadowOffset = .init(width: 0, height: -5)
        textView.layer.shadowColor = UIColor.lightGray.cgColor
        
        addSubview(postImageView)
        postImageView.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.bottom).offset(-40)
            make.leading.equalTo(16)
            make.width.equalTo(100)
            make.height.equalTo(120)
        }
        
        let infoStack = UIStackView(arrangedSubviews: [titleLabel, infoLabel])
        infoStack.axis = .vertical
        
        addSubview(infoStack)
        infoStack.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.bottom).offset(13)
            make.leading.equalTo(postImageView.snp.trailing).offset(8)
        }

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Action
    
    @objc func didTapLike() {
        delegate?.didTapLike()
    }
    
    @objc func didTapUnLike() {
        delegate?.didTapUnLike()
    }
    
    @objc func TapWish() {
        delegate?.TapWish(self)
    }
    
    // MARK: - Helpers
    
    func configureViewModel() {
        let viewModel = PostViewModel()
        textLabel.attributedText = viewModel.ReviewText
    }
}

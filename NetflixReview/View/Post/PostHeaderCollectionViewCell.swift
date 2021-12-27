//
//  PostHeaderCollectionViewCell.swift
//  NetflixReview
//
//  Created by 강호성 on 2021/10/22.
//

import UIKit
import SnapKit

protocol PostHeaderCellDelegate: AnyObject {
    func didTapLike()
    func didTapUnLike()
    func tapSeeMore()
}

class PostHeaderCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    weak var delegate: PostHeaderCellDelegate?

    var ValueViewModel: ValueViewModel? {
        didSet { configureViewModel() }
    }
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "인피니티 워 이후 절반만 살아남은 지구 마지막 희망이 된 어벤져스 먼저 떠난 그들을 위해 모든 것을 걸었다! 운명을 바꿀 최후의 전쟁이 펼쳐진다!"
        label.textColor = .black
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    lazy var seeMoreButton: UIButton = {
        let button = UIButton()
        button.setTitle("더보기", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.addTarget(self, action: #selector(tapSeeMore), for: .touchUpInside)
        return button
    }()
    
    private lazy var textView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        let stack = UIStackView(arrangedSubviews: [reviewLabel, countLabel])
        stack.axis = .horizontal

        view.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(25)
            make.width.equalTo(100)
            make.height.equalTo(50)
        }

        return view
    }()
    
    private let reviewLabel: UILabel = {
        let label = UILabel()
        label.text = "리뷰"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.text = "2,300개"
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("추천해요", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.tintColor = .systemGreen
        button.layer.cornerRadius = 10
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(didTapLike), for: .touchUpInside)
        return button
    }()

    private lazy var unlikeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("별로예요", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.tintColor = .systemPink
        button.layer.cornerRadius = 10
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(didTapUnLike), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViewModel()
        configureUI()
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
    
    @objc func tapSeeMore() {
        delegate?.tapSeeMore()
    }
    
    // MARK: - Helper
    
    func configureViewModel() {
        guard let viewModel = ValueViewModel else { return }
        descriptionLabel.text = viewModel.desciption
    }
    
    func configureUI() {
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(15)
            make.trailing.equalTo(-15)
        }
        
        addSubview(textView)
        textView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        
        addSubview(seeMoreButton)
        seeMoreButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }

        addSubview(likeButton)
        likeButton.snp.makeConstraints { make in
            make.bottom.equalTo(textView.snp.top).offset(-15)
            make.leading.equalTo(10)
            make.width.equalTo(frame.width/2-14)
            make.height.equalTo(50)
        }

        addSubview(unlikeButton)
        unlikeButton.snp.makeConstraints { make in
            make.top.equalTo(likeButton)
            make.leading.equalTo(likeButton.snp.trailing).offset(10)
            make.trailing.equalTo(-10)
            make.height.equalTo(50)
        }
        
    }
    
}

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
    func TapWish()
}

class PostHeader: UICollectionReusableView {
    
    // MARK: - Properties
    
    weak var delegate: PostHeaderDelegate?
    
    var ValueViewModel: ValueVM? {
        didSet { configureViewModel() }
    }
    
    
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
        
        backgroundImage.addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.top.leading.trailing.height.equalTo(backgroundImage)
        }
        
        view.addSubview(wishButton)
        wishButton.snp.makeConstraints { make in
            make.bottom.equalTo(-10)
            make.trailing.equalTo(-20)
            make.width.height.equalTo(30)
        }
        
        return view
    }()
    
    private var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.5)
        return view
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("추천해요", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.tintColor = .systemGreen
        button.layer.cornerRadius = 10
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(didTapLike), for: .touchUpInside)
        return button
    }()

    private lazy var unlikeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("별로예요", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.tintColor = .systemPink
        button.layer.cornerRadius = 10
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(didTapUnLike), for: .touchUpInside)
        return button
    }()
    
    private lazy var percentLabel: UILabel = {
        let label = UILabel()
        label.text = "87%"
        label.textColor = .systemGreen
        label.font = UIFont.boldSystemFont(ofSize: 30)
        return label
    }()

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
        button.setTitleColor(.systemPink, for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .white
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(TapWish), for: .touchUpInside)
        return button
    }()
    
    private lazy var postImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        iv.image = #imageLiteral(resourceName: "end")
        return iv
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "어벤져스: 엔드게임"
        label.textColor = .black
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.text = "영화 ∙ 2019 ∙ 181분"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .lightGray
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "인피니티 워 이후 절반만 살아남은 지구 마지막 희망이 된 어벤져스 먼저 떠난 그들을 위해 모든 것을 걸었다! 위대한 어벤져스 운명을 바꿀 최후의 전쟁이 펼쳐진다!"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 17)
        label.numberOfLines = 4
        return label
    }()

    private lazy var textView: UIView = {
        let view = UIView()
        view.backgroundColor = .white

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
            make.top.equalTo(containerView.snp.bottom).offset(-70)
            make.leading.equalTo(20)
            make.width.equalTo(100)
            make.height.equalTo(150)
        }
        postImageView.layer.cornerRadius = 10
        
        let infoStack = UIStackView(arrangedSubviews: [titleLabel, infoLabel])
        infoStack.axis = .vertical
        infoStack.spacing = 5
        
        addSubview(infoStack)
        infoStack.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.bottom).offset(13)
            make.leading.equalTo(postImageView.snp.trailing).offset(10)
            make.trailing.equalTo(-50)
        }
        
        addSubview(percentLabel)
        percentLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.bottom).offset(40)
            make.trailing.equalTo(-17)
        }
        
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(postImageView.snp.bottom).offset(20)
            make.leading.equalTo(15)
            make.trailing.equalTo(-15)
        }
        
        
        addSubview(likeButton)
        likeButton.snp.makeConstraints { make in
            make.bottom.equalTo(textView.snp.top).offset(-15)
            make.leading.equalTo(10)
            make.width.equalTo(frame.width/2-10)
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
        delegate?.TapWish()
    }
    
    // MARK: - ViewModel
    
    func configureViewModel() {
        guard let viewModel = ValueViewModel else { return }

        titleLabel.text = viewModel.title
        let data = try? Data(contentsOf: viewModel.postImageView!)
        postImageView.image = UIImage(data: data!)
        
        let backData = try? Data(contentsOf: viewModel.backgroundView!)
        backgroundImage.image = UIImage(data: backData!)
        infoLabel.text = viewModel.info
        percentLabel.text = String(viewModel.rank)
        descriptionLabel.text = viewModel.desciption
        textLabel.attributedText = viewModel.ReviewText
 
    }
}



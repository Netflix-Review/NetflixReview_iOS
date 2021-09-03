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
    func writeReview()
}

class PostHeader: UICollectionReusableView {
    
    // MARK: - Properties
    
    weak var delegate: PostHeaderDelegate?
    
    var ContentsViewModel: ContentsViewModel? {
        didSet { configureContentsViewModel() }
    }
    
    var MovieViewModel: MovieViewModel? {
        didSet { configureMovieViewModel() }
    }
    
    var TvProgramViewModel: TvProgramViewModel? {
        didSet { configureTvViewModel() }
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
    
    private lazy var likeView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        view.addSubview(likeButton)
        likeButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(10)
            make.width.equalTo(frame.width/3 - 15)
            make.height.equalTo(50)
        }

        view.addSubview(unlikeButton)
        unlikeButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(likeButton.snp.trailing).offset(10)
            make.width.equalTo(likeButton)
            make.height.equalTo(likeButton)
        }
        
        view.addSubview(writeButton)
        writeButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(unlikeButton.snp.trailing).offset(10)
            make.width.equalTo(likeButton)
            make.height.equalTo(likeButton)
        }
        
        return view
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("추천해요", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 10
        button.tintColor = .white
        button.backgroundColor = .systemGreen
        button.addTarget(self, action: #selector(didTapLike), for: .touchUpInside)
        return button
    }()

    private lazy var unlikeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("별로예요", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 10
        button.tintColor = .white
        button.backgroundColor = .red.withAlphaComponent(0.7)
        button.addTarget(self, action: #selector(didTapUnLike), for: .touchUpInside)
        return button
    }()
    
    private lazy var writeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("리뷰작성", for: .normal)
        button.setTitleColor(.systemPink, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemPink.cgColor
        button.backgroundColor = .white
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(writeReview), for: .touchUpInside)
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
        iv.backgroundColor = .blue
        iv.image = #imageLiteral(resourceName: "end")
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
        configureMovieViewModel()
        
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
        
        addSubview(infoStack)
        infoStack.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.bottom).offset(13)
            make.leading.equalTo(postImageView.snp.trailing).offset(10)
        }
        
        addSubview(percentLabel)
        percentLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.bottom).offset(25)
            make.trailing.equalTo(-17)
        }
        
        addSubview(likeView)
        likeView.snp.makeConstraints { make in
            make.top.equalTo(postImageView.snp.bottom).offset(20)
            make.leading.trailing.width.equalToSuperview()
            make.height.equalTo(80)
        }
        likeView.layer.shadowOpacity = 0.25
        likeView.layer.shadowRadius = 10
        likeView.layer.shadowOffset = .init(width: 0, height: -5)
        likeView.layer.shadowColor = UIColor.lightGray.cgColor
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
    
    @objc func writeReview() {
        delegate?.writeReview()
    }
    
    // MARK: - ViewModel
    
    func configureContentsViewModel() {
        guard let viewModel = ContentsViewModel else { return }

        titleLabel.text = viewModel.contents_title
        let data = try? Data(contentsOf: viewModel.contents_postImageView!)
        postImageView.image = UIImage(data: data!)
        backgroundImage.image = UIImage(data: data!)
        
        textLabel.attributedText = viewModel.ReviewText
    }
    
    func configureMovieViewModel() {
        guard let viewModel = MovieViewModel else { return }

        titleLabel.text = viewModel.movie_title
        let data = try? Data(contentsOf: viewModel.movie_postImageView!)
        postImageView.image = UIImage(data: data!)
        backgroundImage.image = UIImage(data: data!)
        
        textLabel.attributedText = viewModel.ReviewText
    }
    
    func configureTvViewModel() {
        guard let viewModel = TvProgramViewModel else { return }

        titleLabel.text = viewModel.tvProgram_title
        let data = try? Data(contentsOf: viewModel.tvProgram_postImageView!)
        postImageView.image = UIImage(data: data!)
        backgroundImage.image = UIImage(data: data!)
        
        textLabel.attributedText = viewModel.ReviewText
    }
}



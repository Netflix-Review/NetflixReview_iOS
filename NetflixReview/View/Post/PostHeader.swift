//
//  PostHeader.swift
//  NetflixReview
//
//  Created by 강호성 on 2021/08/16.
//

import UIKit
import SnapKit

protocol PostHeaderDelegate: AnyObject {
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
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
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
        label.text = "어벤져스: 엔드게임 어벤져스: 엔드게임 어벤져스: 엔드게임 어벤져스: 엔드게임 어벤져스: 엔드게임 "
        label.textColor = .black
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.text = "영화 ∙ 2019 ∙ 181분"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        return label
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
    }
    
    func configureUI() {
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(250)
        }
        
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
            make.trailing.equalTo(-20)
        }
        
        addSubview(percentLabel)
        percentLabel.snp.makeConstraints { make in
            make.leading.equalTo(postImageView.snp.trailing).offset(10)
            make.bottom.equalTo(infoStack.snp.top).offset(-20)
        }
    }
}

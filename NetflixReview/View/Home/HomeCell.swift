//
//  HomeCell.swift
//  NetflixReview
//
//  Created by 강호성 on 2021/08/17.
//

import UIKit
import SnapKit

class HomeCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    private lazy var postImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.layer.cornerRadius = 10
        iv.backgroundColor = .lightGray
        iv.image = #imageLiteral(resourceName: "end")
        return iv
    }()
    
    private let rankLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.backgroundColor = .systemPink
        label.clipsToBounds = true
        label.layer.cornerRadius = 5
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "어벤져스: 엔드게임"
        label.textColor = .black
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    // MARK: - Fetch
    
    var contents: Value! {
        didSet {
            self.titleLabel.text = self.contents.title
            self.rankLabel.text = "\(self.contents.list)"
            self.postImageView.setImage(imageUrl: self.contents.post)
        }
    }
    
    var movie: Value! {
        didSet {
            self.titleLabel.text = self.movie.title
            self.rankLabel.text = "\(self.movie.list)"
            self.postImageView.setImage(imageUrl: self.movie.post)
        }
    }
    
    var tvprogram: Value! {
        didSet {
            self.titleLabel.text = self.tvprogram.title
            self.rankLabel.text = "\(self.tvprogram.list)"
            self.postImageView.setImage(imageUrl: self.tvprogram.post)
        }
    }
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(postImageView)
        postImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        addSubview(rankLabel)
        rankLabel.snp.makeConstraints { make in
            make.top.equalTo(postImageView.snp.bottom).offset(8)
            make.leading.equalTo(postImageView).offset(3)
            make.width.height.equalTo(20)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(postImageView.snp.bottom).offset(9)
            make.leading.equalTo(rankLabel.snp.trailing).offset(5)
            make.trailing.equalTo(postImageView)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

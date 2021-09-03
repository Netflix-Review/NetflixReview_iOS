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
        iv.image = #imageLiteral(resourceName: "end")
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "어벤져스: 엔드게임"
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    // MARK: - Fetch
    
    var contents: Contents! {
        didSet {
            self.titleLabel.text = self.contents.title
            self.postImageView.setImage(imageUrl: self.contents.post)
        }
    }
    
    var movie: Movie! {
        didSet {
            self.titleLabel.text = self.movie.title
            self.postImageView.setImage(imageUrl: self.movie.post)
        }
    }
    
    var tvprogram: tvProgram! {
        didSet {
            self.titleLabel.text = self.tvprogram.title
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
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(postImageView.snp.bottom).offset(8)
            make.leading.equalTo(postImageView).offset(3)
            make.trailing.equalTo(postImageView)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

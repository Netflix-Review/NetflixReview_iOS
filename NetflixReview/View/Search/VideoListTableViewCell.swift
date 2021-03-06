//
//  VideoListTableViewCell.swift
//  NetflixReview
//
//  Created by 강호성 on 2021/08/16.
//

import UIKit
import SnapKit

class VideoListTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    var value: Value? {
        didSet { configure() }
    }
    
    lazy var postImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.layer.cornerRadius = 10
        iv.image = #imageLiteral(resourceName: "end")
        return iv
    }()
    
    let videoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.text = "어벤져스: 엔드게임"
        return label
    }()
    
    lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.text = "영화 ∙ 2019 ∙ 181분"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(postImageView)
        postImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(16)
            make.width.equalTo(80)
            make.height.equalTo(100)
        }
        
        let stack = UIStackView(arrangedSubviews: [videoLabel, infoLabel])
        stack.axis = .vertical
        
        addSubview(stack)
        stack.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(postImageView.snp.trailing).offset(15)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper
    
    func configure() {
        guard let value = value else { return }
        
        postImageView.setImage(imageUrl: value.post)
        videoLabel.text = value.title
        infoLabel.text = value.info
    }
}

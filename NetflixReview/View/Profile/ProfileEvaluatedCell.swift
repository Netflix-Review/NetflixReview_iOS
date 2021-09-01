//
//  ProfileEvaluatedCell.swift
//  NetflixReview
//
//  Created by 강호성 on 2021/08/19.
//

import UIKit
import SnapKit

class ProfileEvaluatedCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "영상 제목"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.backgroundColor = .blue
        return label
    }()
    
    private let reviewLabel: UILabel = {
        let label = UILabel()
        label.text = "내가 쓴 리뷰"
        label.numberOfLines = 2
        label.backgroundColor = .green
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
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        backgroundColor = .red
        
//        addSubview(titleLabel)
//        titleLabel.snp.makeConstraints { make in
//            make.top.equalTo(10)
//            make.leading.equalTo(16)
//            make.trailing.equalTo(-30)
//        }
    }
}

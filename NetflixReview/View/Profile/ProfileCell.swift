//
//  ProfileCell.swift
//  NetflixReview
//
//  Created by 강호성 on 2021/08/16.
//

import UIKit
import SnapKit

class ProfileCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    private lazy var postImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.layer.cornerRadius = 10
        iv.layer.borderWidth = 2
        iv.layer.borderColor = UIColor.white.cgColor
        iv.backgroundColor = .lightGray
        iv.image = #imageLiteral(resourceName: "end")
        return iv
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(postImageView)
        postImageView.snp.makeConstraints { make in
            make.top.equalTo(15)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(180)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

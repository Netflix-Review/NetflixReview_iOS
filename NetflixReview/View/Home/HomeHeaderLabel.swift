//
//  HomeHeaderLabel.swift
//  NetflixReview
//
//  Created by 강호성 on 2021/09/01.
//

import UIKit

class HomeHeaderLabel: UICollectionReusableView {
    
    // MARK: - Properties
    
    let label = UILabel()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        label.text = "순위"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  EditInfoCell.swift
//  NetflixReview
//
//  Created by 강호성 on 2021/08/30.
//

import UIKit
import SnapKit

class EditInfoCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    let tk = TokenUtils()
    private let baseUrl = "http://219.249.59.254:3000"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "이름"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    lazy var infoText: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .none
        tf.font = UIFont.systemFont(ofSize: 18)
        tf.textColor = .black
        tf.textAlignment = .left
        return tf
    }()
    
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureUserName()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Helpers
    
    func configureUI() {
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(30)
        }
        
        contentView.addSubview(infoText)
        infoText.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.trailing).offset(30)
            make.centerY.equalToSuperview()
        }
    }
    
    func configureUserName() {
        let username = tk.load(baseUrl + "/api/login", account: "username")
        infoText.text = username
    }
    
}

//
//  EditInfoCollectionViewCell.swift
//  NetflixReview
//
//  Created by 강호성 on 2021/08/30.
//

import UIKit
import SnapKit

protocol EditNameDelegate: AnyObject {
    func changeName(_ cell: EditInfoCollectionViewCell)
}

class EditInfoCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    weak var delegate: EditNameDelegate?
    
    let tk = TokenUtils()
    private let baseUrl = "http://61.254.56.218:3000"
    
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
    
    let changeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("변경", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(changeName), for: .touchUpInside)
        return button
    }()
    
    let explanationLabel: UILabel = {
        let label = UILabel()
        label.text = "닉네임은 3~15자리로 입력해주세요."
        label.textColor = .lightGray
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
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
            make.centerY.equalToSuperview()
            make.leading.equalTo(titleLabel.snp.trailing).offset(25)
            make.width.equalTo(200)
        }
        
        contentView.addSubview(changeButton)
        changeButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(-20)
        }
        
        addSubview(explanationLabel)
        explanationLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.bottom).offset(10)
            make.leading.equalTo(30)
        }
    }
    
    func configureUserName() {
        let username = tk.load(baseUrl + "/api/login", account: "username")
        infoText.text = username
    }
    
    // MARK: - Action
    
    @objc func changeName() {
        delegate?.changeName(self)
    }
    
}

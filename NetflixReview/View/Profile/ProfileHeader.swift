//
//  ProfileHeader.swift
//  NetflixReview
//
//  Created by 강호성 on 2021/08/16.
//

import UIKit
import SnapKit

protocol ProfileHeaderDelegate: AnyObject {
    func didSelect(filter: HeaderFIlterOptions)
    func editName()
}

class ProfileHeader: UICollectionReusableView {
    
    // MARK: - Properties
    
    weak var delegate: ProfileHeaderDelegate?
    
    let tk = TokenUtils()
    private let baseUrl = "http://219.249.59.254:3000"
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 30)
        return label
    }()
    
    private lazy var editNameButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("이름 변경", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.setTitleColor(.lightGray, for: .normal)
        button.addTarget(self, action: #selector(editNameButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let filterBar = HeaderFilterView()
    
    // MARK: - Actions
    
    @objc func editNameButtonTapped() {
        delegate?.editName()
    }
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHeader()
        configureUserName()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configureHeader() {
        
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(20)
        }
        
        addSubview(editNameButton)
        editNameButton.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.leading.equalTo(nameLabel).offset(5)
        }

        addSubview(filterBar)
        filterBar.snp.makeConstraints { make in
            make.top.equalTo(100)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(60)
        }
    }
    
    func configureUserName() {
        let username = tk.load(baseUrl + "/api/login", account: "username")
        nameLabel.text = "\(username ?? "")님"
    }
}

// MARK: - HeaderFilterViewDelegate

extension ProfileHeader: HeaderFilterViewDelegate {
    func filterView(_ view: HeaderFilterView, didSelect index: Int) {
        
        guard let filter = HeaderFIlterOptions(rawValue: index) else { return }
        delegate?.didSelect(filter: filter)
    }
}

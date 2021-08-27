//
//  EditNameCell.swift
//  NetflixReview
//
//  Created by 강호성 on 2021/08/19.
//

import UIKit
import SnapKit

class EditNameCell: UITableViewCell {
    
    // MARK: - Properties
    
    var viewModel: EditNameViewModel? {
        didSet { configureViewModel() }
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    lazy var infoText: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .none
        tf.font = UIFont.systemFont(ofSize: 18)
        tf.textAlignment = .left
        tf.textColor = .lightGray
        tf.addTarget(self, action: #selector(updataUserInfo), for: .editingDidEnd)
        return tf
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        configureViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Action
    
    @objc func updataUserInfo() {
        print("이름 업데이트")
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        backgroundColor = .white
        selectionStyle = .none
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(20)
        }
        
        contentView.addSubview(infoText)
        infoText.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.trailing).offset(30)
            make.centerY.equalToSuperview()
        }
    }
    
    func configureViewModel() {
        guard let viewModel = viewModel else { return }
        
        titleLabel.text = viewModel.titleText
        infoText.text = viewModel.optionValue
    }
}

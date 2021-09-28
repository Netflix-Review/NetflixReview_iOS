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
    
    var viewModel: EditNameVM? {
        didSet { configureViewModel() }
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    lazy var infoText: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .none
        tf.font = UIFont.systemFont(ofSize: 18)
        tf.textAlignment = .left
        tf.addTarget(self, action: #selector(updataUserInfo), for: .editingDidEnd)
        return tf
    }()
    
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
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
    
    func configureViewModel() {
        guard let viewModel = viewModel else { return }
        
        titleLabel.text = viewModel.titleText
        infoText.text = viewModel.optionValue
    }
    
}

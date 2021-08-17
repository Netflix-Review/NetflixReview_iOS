//
//  PostReviewViewController.swift
//  NetflixReview
//
//  Created by 강호성 on 2021/08/17.
//

import UIKit

class PostReviewViewController: UIViewController {
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "User"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let reviewLabel: UILabel = {
        let label = UILabel()
        label.text = "review review review review review review review review review review review review review review review review review review review review review review review review review review review review review review review review review review review review review review review review review review review review review review review review review review "
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "5일 전"
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    // MARK: - Action
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
    }
    
    func configureUI() {
        view.backgroundColor = .white
        
        let containerView: UIView = {
            let view = UIView()
            view.backgroundColor = .systemBackground

            view.addSubview(nameLabel)
            nameLabel.snp.makeConstraints { make in
                make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
                make.leading.equalTo(25)
            }
            
            view.addSubview(reviewLabel)
            reviewLabel.snp.makeConstraints { make in
                make.top.equalTo(nameLabel.snp.bottom).offset(15)
                make.leading.equalTo(20)
                make.trailing.equalTo(-20)
            }

            view.addSubview(timeLabel)
            timeLabel.snp.makeConstraints { make in
                make.top.equalTo(nameLabel)
                make.trailing.equalTo(-20)
            }
            return view
        }()
        
        view.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.height.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        containerView.layer.cornerRadius = 10
        containerView.layer.shadowOpacity = 0.25
        containerView.layer.shadowRadius = 10
        containerView.layer.shadowOffset = .init(width: 0, height: -5)
        containerView.layer.shadowColor = UIColor.lightGray.cgColor
    }
}

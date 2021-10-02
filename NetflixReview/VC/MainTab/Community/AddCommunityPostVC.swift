//
//  AddCommunityPostVC.swift
//  NetflixReview
//
//  Created by 강호성 on 2021/08/19.
//

import UIKit
import SnapKit

class AddCommunityPostVC: UIViewController {
    
    // MARK: - Properties
    
    private lazy var captionTextView: InputTextView = {
        let tv = InputTextView()
        tv.placeholderText = "커뮤니티에 새로운 글을 등록해보세요."
        tv.backgroundColor = .white
        tv.font = UIFont.systemFont(ofSize: 18)
        return tv
    }()
    
    private lazy var doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("커뮤니티에 업로드하기", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.addTarget(self, action: #selector(handleDone), for: .touchUpInside)
        return button
    }()
    
    var restoreFrameValue: CGFloat = 0.0
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.frame.origin.y = restoreFrameValue
        self.view.endEditing(true)
    }
    
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        navigationItem.title = "새 글"
        
        view.addSubview(captionTextView)
        captionTextView.snp.makeConstraints { make in
            make.top.equalTo(170)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.height.equalTo(500)
        }
        
        view.addSubview(doneButton)
        doneButton.snp.makeConstraints { make in
            make.top.equalTo(captionTextView.snp.bottom).offset(5)
            make.trailing.equalTo(-20)
            make.width.equalTo(170)
            make.height.equalTo(30)
        }
    }
    
    // MARK: - Action
    
    @objc func handleDone() {
        print("done")
    }
}

//
//  WriteReviewVC.swift
//  NetflixReview
//
//  Created by 강호성 on 2021/08/31.
//

import UIKit
import SnapKit

class WriteReviewVC: UIViewController {
    
    // MARK: - Properties
    
    private lazy var captionTextView: InputTextView = {
        let tv = InputTextView()
        tv.placeholderText = "작품에 대한 감상평을 남겨주세요."
        tv.font = UIFont.systemFont(ofSize: 18)
        return tv
    }()
    
    private lazy var doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("리뷰 업로드하기", for: .normal)
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
        navigationItem.title = "리뷰 작성"
        
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

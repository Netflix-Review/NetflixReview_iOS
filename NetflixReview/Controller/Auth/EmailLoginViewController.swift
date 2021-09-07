//
//  EmailLoginViewController.swift
//  NetflixReview
//
//  Created by 강호성 on 2021/09/07.
//

import UIKit
import SnapKit

class EmailLoginViewController: UIViewController {
    
    // MARK: - Properties
        
    private var emailTitle: UILabel = {
        let label = UILabel()
        label.text = "이메일"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private var passwordTitle: UILabel = {
        let label = UILabel()
        label.text = "비밀번호"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private var emailTextField: UITextField = {
        let tf = LoginUtil().textField(withPlaceholder: "예) netflix@gmail.com")
        return tf
    }()
    
    private var passwordField: UITextField = {
        let tf = LoginUtil().textField(withPlaceholder: "비밀번호를 입력해주세요.")
        return tf
    }()
    
    private lazy var emailContainerView: UIView = {
        let view = LoginUtil().inputContainerView(textField: emailTextField)
        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
        let view = LoginUtil().inputContainerView(textField: passwordField)
        return view
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("로그인", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemPink
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    private let dontHaveAccountButton: UIButton = {
        let button = LoginUtil().attributedButton("아직 회원이 아니신가요?  ", "회원가입")
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()

    }
    
    // MARK: - Action
    
    @objc func handleDismiss() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleLogin() {
        print("로그인")
    }
    
    @objc func handleShowSignUp() {
        let controller = RegistrationViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
    // MARK: - Helper
    
    func configureUI() {
        view.backgroundColor = .white
        
        let emailStack = UIStackView(arrangedSubviews: [emailTitle, emailContainerView])
        emailStack.axis = .vertical
        emailStack.spacing = 5
        
        view.addSubview(emailStack)
        emailStack.snp.makeConstraints { make in
            make.top.equalTo(200)
            make.leading.equalTo(view.snp.leading).offset(25)
            make.trailing.equalTo(view.snp.trailing).offset(-25)
        }
        
        let passwordStack = UIStackView(arrangedSubviews: [passwordTitle, passwordContainerView])
        passwordStack.axis = .vertical
        passwordStack.spacing = 5
        
        view.addSubview(passwordStack)
        passwordStack.snp.makeConstraints { make in
            make.top.equalTo(emailStack.snp.bottom).offset(30)
            make.leading.equalTo(view.snp.leading).offset(25)
            make.trailing.equalTo(view.snp.trailing).offset(-25)
        }
        
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.leading.equalTo(5)
            make.width.height.equalTo(50)
        }
        
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordStack.snp.bottom).offset(30)
            make.leading.trailing.equalTo(emailStack)
        }
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.leading.trailing.equalTo(loginButton)
        }
    }
    
    
    
}

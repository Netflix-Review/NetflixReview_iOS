//
//  RegistrationVC.swift
//  NetflixReview
//
//  Created by 강호성 on 2021/09/07.
//

import UIKit
import SnapKit
import Alamofire
import JGProgressHUD


class RegistrationVC: UIViewController {
    
    // MARK: - Properties

    private let baseUrl = "http://219.249.59.254:3000"
        
    private var emailTitle: UILabel = {
        let label = UILabel()
        label.text = "이메일"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private var passwordTitle: UILabel = {
        let label = UILabel()
        label.text = "비밀번호"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private var nameTitle: UILabel = {
        let label = UILabel()
        label.text = "이름"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private var emailTextField: UITextField = {
        let tf = LoginUtil().textField(withPlaceholder: "예) netflix@gmail.com")
        return tf
    }()
    
    private var passwordField: UITextField = {
        let tf = LoginUtil().textField(withPlaceholder: "비밀번호는 6자리이상 입력해주세요.")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private var nameField: UITextField = {
        let tf = LoginUtil().textField(withPlaceholder: "닉네임은 3~15자리로 입력해주세요.")
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
    
    private lazy var nameContainerView: UIView = {
        let view = LoginUtil().inputContainerView(textField: nameField)
        return view
    }()
    
    
    private let registrationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("회원가입", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemPink
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
    }()
    
    private let alreadyhaveAccount: UIButton = {
        let button = LoginUtil().attributedButton("이미 회원이신가요?  ", "돌아가기")
        button.addTarget(self, action: #selector(backLoginView), for: .touchUpInside)
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
    
    @objc func handleSignUp() {
        print("회원가입")
        guard let email = emailTextField.text else { return }
        guard let password = passwordField.text else { return }
        guard let username = nameField.text else { return }
        
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "회원가입 중"
        hud.show(in: view)
        
        let url = URL(string: baseUrl + "/api/sign-up")!
        let params = ["email": email, "password": password, "username": username]
        
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: ["Content-Type": "application/json"]).responseJSON { response in
            
            switch response.result {
            case .success(let data):
                print("성공, \(data)")
                
                AlertHelper.defaultAlert(title: "환영합니다 👏👏", message: "회원가입을 완료했습니다!", okMessage: "로그인 하러가기", over: self)
                hud.dismiss()
                
            case .failure(let error):
                print("Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
            }
        }
    }
    
    @objc func backLoginView() {
        navigationController?.popViewController(animated: true)
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
        
        let nameStack = UIStackView(arrangedSubviews: [nameTitle, nameContainerView])
        nameStack.axis = .vertical
        nameStack.spacing = 5
        
        view.addSubview(nameStack)
        nameStack.snp.makeConstraints { make in
            make.top.equalTo(passwordStack.snp.bottom).offset(30)
            make.leading.equalTo(view.snp.leading).offset(25)
            make.trailing.equalTo(view.snp.trailing).offset(-25)
        }
        
        view.addSubview(registrationButton)
        registrationButton.snp.makeConstraints { make in
            make.top.equalTo(nameStack.snp.bottom).offset(30)
            make.leading.trailing.equalTo(nameStack)
        }
        
        view.addSubview(alreadyhaveAccount)
        alreadyhaveAccount.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.leading.trailing.equalTo(registrationButton)
        }
    }
}

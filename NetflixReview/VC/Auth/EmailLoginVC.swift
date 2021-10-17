//
//  EmailLoginVC.swift
//  NetflixReview
//
//  Created by 강호성 on 2021/09/07.
//

import UIKit
import SnapKit
import JGProgressHUD
import Alamofire
import SwiftyJSON

class EmailLoginVC: UIViewController {
    
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
    
    private var emailTextField: UITextField = {
        let tf = LoginUtil().textField(withPlaceholder: "예) netflix@gmail.com")
        return tf
    }()
    
    private var passwordField: UITextField = {
        let tf = LoginUtil().textField(withPlaceholder: "비밀번호를 입력해주세요.")
        tf.isSecureTextEntry = true
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
        
        guard let email = emailTextField.text else { return }
        guard let password = passwordField.text else { return }
        
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "로그인 중"
        hud.show(in: view)
        
        let url = URL(string: baseUrl + "/api/login")!
        let params = ["email": email, "password": password]
        
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: ["Content-Type": "application/json"]).responseJSON { response in
            
            switch response.result {
            case .success(let data):
                print("성공, \(data)")
                
                let json = JSON(data)
                let result = json["message"].stringValue
                let username = json["username"].stringValue
                let accessToken = json["token"].stringValue
                
                // 토큰 정보 키체인에 저장
                let tk = TokenUtils()
                tk.create("\(url)", account: "accessToken", value: accessToken)
                tk.create("\(url)", account: "username", value: username)
                
                if result == "login success" {
                    // 로그인 성공 후 메인탭으로 전환
                    guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
                    guard let tab = window.rootViewController as? MainTabVC else { return }
                    tab.checkLoginedUser()
                    
                } else {
                    AlertHelper.defaultAlert(title: "로그인 실패", message: "이메일과 비밀번호를 다시한번 확인해주세요.", okMessage: "로그인 다시하기", over: self)
                }
                
                hud.dismiss()
                self.dismiss(animated: true, completion: nil)
                
            case .failure(let error):
                print("Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
            }
        }
    

    }
    
    @objc func handleShowSignUp() {
        let controller = RegistrationVC()
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

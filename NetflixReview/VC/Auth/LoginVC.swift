//
//  LoginVC.swift
//  NetflixReview
//
//  Created by 강호성 on 2021/09/02.
//

import UIKit
import SnapKit
import Alamofire
import KakaoSDKAuth
import KakaoSDKUser

class LoginVC: UIViewController {
    
    // MARK: - Properties
    
    private let baseUrl = "http://219.249.59.254:3000"
    
    var containerView = UIView()
    var slideUpView = UIView()
    let slideUpViewHeight: CGFloat = 300
    
    private var goToLoginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("시작하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.addTarget(self, action: #selector(goToLogin), for: .touchUpInside)
        return button
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "SNS 및 E-mail 로그인"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private lazy var kakaoImage: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "kakao_login_medium_wide")
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(kakaoLogin))
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(tap)
        
        return iv
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "email로 시작하기"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .lightGray
        
        let emailTap = UITapGestureRecognizer(target: self, action: #selector(goEmailLogin))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(emailTap)
        
        return label
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        
        configureBackgroundImage()
        configureMainView()
        configureSlideView()
    }
    
    // MARK: - Helpers
    
    func configureBackgroundImage() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "logo")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFit
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    func configureMainView() {
        view.addSubview(goToLoginButton)
        goToLoginButton.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    func configureSlideView() {
        
        slideUpView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(40)
            make.leading.equalTo(25)
        }
        
        slideUpView.addSubview(kakaoImage)
        kakaoImage.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
        }
        
        slideUpView.addSubview(emailLabel)
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(kakaoImage.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
        }
    }
    
    // 사용자 정보 불러오기
    func setKakaoUserInfo() {
        UserApi.shared.me() {(user, error) in
            if let error = error {
                print(error)
            }
            else {
                print("me() success.")
                //do something
                _ = user
            }
        }
    }
    
    // MARK: - Action (Slide Up, Down)
    
    @objc func goToLogin() {
        
        // addsubView _ containerView, slideUpView 가 현재 메서드에 있는 이유는
        // 로그인을 눌렀을 때, 다시 로그인이 안눌러지도록 하기위해
        
        view.addSubview(containerView)
        containerView.frame = self.view.frame
        containerView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(slideViewDown))
        containerView.addGestureRecognizer(tapGesture)
        containerView.alpha = 0
        
        let screenSize = UIScreen.main.bounds.size
        view.addSubview(slideUpView)
        slideUpView.backgroundColor = .white
        slideUpView.layer.cornerRadius = 15
        slideUpView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        slideUpView.frame = CGRect(x: 0, y: screenSize.height,
                                   width: screenSize.width, height: slideUpViewHeight)
        
        // 슬라이드 뷰 올리기
        UIView.animate(withDuration: 0.5,
                       delay: 0, usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 1.0,
                       options: .curveEaseInOut,
                       animations: {
                        self.containerView.alpha = 0.8
                        self.slideUpView.frame = CGRect(x: 0,
                                                        y: screenSize.height - self.slideUpViewHeight,
                                                        width: screenSize.width,
                                                        height: self.slideUpViewHeight)
                       }, completion: nil)
    }
    
     
    @objc func slideViewDown() {
        // 뷰 다시 원래 색상으로
        UIView.animate(withDuration: 0.5,
                       delay: 0, usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 1.0,
                       options: .curveEaseInOut,
                       animations: {
                        self.containerView.alpha = 0
                       }, completion: nil)
        
        // 슬라이드 뷰 내려감
        let screenSize = UIScreen.main.bounds.size
        UIView.animate(withDuration: 0.5,
                       delay: 0, usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 1.0,
                       options: .curveEaseInOut,
                       animations: {
                        self.containerView.alpha = 0
                        self.slideUpView.frame = CGRect(x: 0,
                                                        y: screenSize.height,
                                                        width: screenSize.width,
                                                        height: self.slideUpViewHeight)
                       }, completion: nil)
    }
    
    @objc func kakaoLogin() {
        print("카카오 로그인")
        
        if UserApi.isKakaoTalkLoginAvailable() { // 해당 폰에 카카오톡 앱이 깔려있을 때
            UserApi.shared.loginWithKakaoTalk { oauthToken, error in
                if let error = error {
                    print(error)
                } else {
                    print("KakaoApp - loginWithKakaoTalk() success")
                    
                    // 발행된 access token 을 서버에 전달 (post)
                    _ = oauthToken
                    
                    self.setKakaoUserInfo()
                }
            }
        } else { // 해당 폰에 카카오톡이 안깔려있으면 웹 브라우저로
            UserApi.shared.loginWithKakaoAccount { oauthToken, error in
                if let error = error {
                    print(error)
                } else {
                    print("Web - loginWithKakaoTalk() success")
                    
                    let url = URL(string: self.baseUrl + "")!

                    let accessToken = oauthToken?.accessToken
                    let param = ["access_token": accessToken!] as Dictionary
                    print("access_token: \(accessToken!)")
                    
                    AF.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: ["Content-Type": "application/json"]).responseJSON { response in
                        switch response.result {
                        case .success(let data):
                            print("Success \(data)")
                        case .failure(let error):
                            print("Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
                        }
                    }
                    
                    self.setKakaoUserInfo()
                }
            }
        }
        
    }
    
    @objc func goEmailLogin() {
        let controller = EmailLoginVC()
        navigationController?.pushViewController(controller, animated: true)
    }
    
}


//
//  LoginViewController.swift
//  NetflixReview
//
//  Created by 강호성 on 2021/09/02.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    
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
    
    private var naverButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("N", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.tintColor = .white
        button.layer.cornerRadius = 50/2
        button.backgroundColor = .systemGreen
        button.addTarget(self, action: #selector(naverLogin), for: .touchUpInside)
        return button
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
        
        slideUpView.addSubview(naverButton)
        naverButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(50)
            make.leading.equalTo(40)
            make.width.height.equalTo(50)
        }
        
        slideUpView.addSubview(emailLabel)
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(naverButton.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
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
    
    
    @objc func naverLogin() {
        print("naver")
    }
    
    @objc func goEmailLogin() {
        let controller = EmailLoginViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
}

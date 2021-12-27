//
//  LoginViewController.swift
//  NetflixReview
//
//  Created by 강호성 on 2021/09/02.
//

import UIKit
import SnapKit
import Alamofire

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    
    private let baseUrl = "http://61.254.56.218:3000"
    
    var containerView = UIView()
    var slideUpView = UIView()
    let slideUpViewHeight: CGFloat = 250
    
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
        label.text = "로그인"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private lazy var emailButton: UIButton = {
        let button = UIButton()
        button.setTitle("email로 시작하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemPink
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.addTarget(self, action: #selector(goEmailLogin), for: .touchUpInside)
        return button
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
        
        slideUpView.addSubview(emailButton)
        emailButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.leading.equalTo(40)
            make.trailing.equalTo(-40)
            make.height.equalTo(50)
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
    
    @objc func goEmailLogin() {
        let controller = EmailLoginViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
}


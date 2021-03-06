//
//  PostCollectionViewController.swift
//  NetflixReview
//
//  Created by 강호성 on 2021/08/16.
//

enum Type {
    case contents
    case movie
    case tv
}

import UIKit
import Alamofire
import JGProgressHUD
import SwiftyJSON

class PostCollectionViewController: UICollectionViewController {
    
    // MARK: - Properties
    
    private let headerId = "PostHeader"
    private let headerCellId = "PostHeaderCell"
    
    var value: Value?
    var type: Type = .contents
    let hud = JGProgressHUD(style: .dark)
    
    var containerView = UIView()
    var slideUpView = UIView()
    let slideUpViewHeight: CGFloat = 350
    
    private var overViewLabel: UILabel = {
        let label = UILabel()
        label.text = "줄거리"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()

    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    
    // MARK: - Lifecycle
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        configureSlideView()
    }
    
    // MARK: - Helpers
    
    func configureSlideView() {
        descriptionLabel.text = value?.des
        
        slideUpView.addSubview(overViewLabel)
        overViewLabel.snp.makeConstraints { make in
            make.top.equalTo(40)
            make.leading.equalTo(50)
        }

        slideUpView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(overViewLabel.snp.bottom).offset(20)
            make.leading.equalTo(30)
            make.trailing.equalTo(-30)
        }
    }
    
    func configureCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.contentInset.bottom = 150
        
        collectionView.register(PostCollectionViewCell.self, forCellWithReuseIdentifier: UICollectionViewCell.reuseIdentifier)
        collectionView.register(PostHeaderCollectionViewCell.self, forCellWithReuseIdentifier: headerCellId)
        collectionView.register(PostHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
    }
    
    func countMethod(updown: String) {
       var urlString = ""
        
        switch type {
        case .contents: urlString = "/plusDrama"
        case .movie: urlString = "/plusMovie"
        case .tv: urlString = "/plusTv"
        }
        
        self.hud.show(in: self.view)
        
        let url = URL(string: URL.baseURL + urlString)!
        let params = ["id": value?.id ?? 0, "rank": updown] as Dictionary
        print(params)
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: ["Content-Type": "application/json"]).responseJSON { response in
            
            print("HTTP Body : " + String(decoding: response.request?.httpBody ?? Data(), as: UTF8.self))
            
            switch response.result {
            case .success(let data):
                
                let json = JSON(data)
                let result = json["RankResult"].intValue
                
                print(json, result)
                self.value?.rank = result
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.hud.dismiss()
                }
                
            case .failure(let error):
                print("Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
            }
        }
    }
    
    // MARK: - Action
    
    @objc func slideUpViewTapped() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.tabBarController?.tabBar.isHidden = false
            self.containerView.alpha = 0
        }, completion: nil)
        
        let screenSize = UIScreen.main.bounds.size
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            self.containerView.alpha = 0
            self.slideUpView.frame = CGRect(x: 0,
                                            y: screenSize.height,
                                            width: screenSize.width,
                                            height: self.slideUpViewHeight)
        }, completion: nil)
    }
}


// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension PostCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0 {
            let headerCell = collectionView.dequeueReusableCell(withReuseIdentifier: headerCellId, for: indexPath) as! PostHeaderCollectionViewCell
            headerCell.backgroundColor = .white
            headerCell.delegate = self
            
            if let value = value {
                headerCell.ValueViewModel = ValueViewModel(value: value)
            }
            
            return headerCell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UICollectionViewCell.reuseIdentifier, for: indexPath) as! PostCollectionViewCell
        cell.layer.cornerRadius = 20
        cell.layer.shadowOpacity = 0.2
        cell.layer.shadowRadius = 10
        cell.layer.shadowOffset = .init(width: 0, height: -2)
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.backgroundColor = .white
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! PostHeader
        
        header.delegate = self
        header.backgroundColor = .white
        
        if let value = value {
            header.ValueViewModel = ValueViewModel(value: value)
        }

        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row != 0 {
            let controller = PostReviewViewController()
            let nav = UINavigationController(rootViewController: controller)
            nav.modalTransitionStyle = .crossDissolve
            present(nav, animated: true, completion: nil)
        }
    }
}


// MARK: - UICollectionViewDelegateFlowLayout

extension PostCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.row == 0 { return CGSize(width: view.frame.width, height: 220) }
        return CGSize(width: view.frame.width-30, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 350)
    }
}

// MARK: - PostHeaderDelegate

extension PostCollectionViewController: PostHeaderDelegate {
    func TapWish() {
        print("찜하기")
    }
    
}

// MARK: - PostHeaderCellDelegate

extension PostCollectionViewController: PostHeaderCellDelegate {
    func didTapLike() {
        print("추천해요")

        AlertHelper.okAndNoHandlerAlert(title: "소중한 의견 감사해요!", message: "작품을 추천하는 이유를 리뷰로 남겨보시겠어요?", onConfirm: {
            self.countMethod(updown: "Up")
            let controller = WriteReviewViewController()
            self.navigationController?.pushViewController(controller, animated: true)
        }, onCancel: {
            self.countMethod(updown: "Up")
            self.dismiss(animated: true, completion: nil)
        }, over: self)

    }

    func didTapUnLike() {
        print("별로예요")

        AlertHelper.okAndNoHandlerAlert(title: "소중한 의견 감사해요!", message: "작품이 별로였던 이유를 리뷰로 남겨보시겠어요?", onConfirm: {
            self.countMethod(updown: "Down")
            let controller = WriteReviewViewController()
            self.navigationController?.pushViewController(controller, animated: true)
        }, onCancel: {
            self.countMethod(updown: "Down")
            self.dismiss(animated: true, completion: nil)
        }, over: self)
    }
    
    func tapSeeMore() {
        view.addSubview(containerView)
        containerView.frame = self.view.frame
        containerView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(slideUpViewTapped))
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
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.tabBarController?.tabBar.isHidden = true
            self.containerView.alpha = 0.8
            self.slideUpView.frame = CGRect(x: 0,
                                            y: screenSize.height - self.slideUpViewHeight,
                                            width: screenSize.width,
                                            height: self.slideUpViewHeight)
        }, completion: nil)
    }
}

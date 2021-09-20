//
//  PostViewController.swift
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

class PostViewController: UICollectionViewController {
    
    // MARK: - Properties
    
    private let headerId = "PostHeader"
    private let cellId = "PostCell"
    
    var value: Value?
    
    private let baseUrl = "http://219.249.59.254:3000"
    
    var type: Type = .contents
    
    let hud = JGProgressHUD(style: .dark)
    
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
    }
    
    // MARK: - Helpers
    
    func configureCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.contentInsetAdjustmentBehavior = .never
        
        collectionView.register(PostCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(PostHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
    }
}


// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension PostViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PostCell
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
        let controller = PostReviewViewController()
        let nav = UINavigationController(rootViewController: controller)
        nav.modalTransitionStyle = .crossDissolve
        present(nav, animated: true, completion: nil)
    }
}


// MARK: - UICollectionViewDelegateFlowLayout

extension PostViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 560)
    }
}

// MARK: - PostHeaderDelegate

extension PostViewController: PostHeaderDelegate {
    
    func TapWish() {
        print("찜하기")
    }
    
    func didTapLike() {
        print("추천해요")

        let actionSheet = UIAlertController(title: "소중한 의견 감사해요 !",
                                            message: "작품을 추천하는 이유를 리뷰로 남겨보시겠어요?",
                                            preferredStyle: .actionSheet)
        let okAction = UIAlertAction(title: "리뷰 쓰러가기", style: .default) { _ in
            self.plusPercentCount()
            
            let controller = WriteReviewViewController()
            self.navigationController?.pushViewController(controller, animated: true)
        }

        let noAction = UIAlertAction(title: "다음에 할게요", style: .destructive) { _ in
            self.plusPercentCount()
            self.dismiss(animated: true, completion: nil)
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { _ in
            self.dismiss(animated: true, completion: nil)
        }
        
        actionSheet.addAction(okAction)
        actionSheet.addAction(noAction)
        actionSheet.addAction(cancelAction)
        present(actionSheet, animated: true, completion: nil)
    }
    
    func didTapUnLike() {
        print("별로예요")
        
        let actionSheet = UIAlertController(title: "소중한 의견 감사해요 !",
                                            message: "작품이 별로였던 이유를 리뷰로 남겨보시겠어요?",
                                            preferredStyle: .actionSheet)
        
        let okAction = UIAlertAction(title: "리뷰 쓰러가기", style: .default) { _ in
            self.minusPercentCount()
            
            let controller = WriteReviewViewController()
            self.navigationController?.pushViewController(controller, animated: true)
        }
        
        let noAction = UIAlertAction(title: "다음에 할게요", style: .destructive) { _ in
            self.minusPercentCount()
            
            self.dismiss(animated: true, completion: nil)
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { _ in
            self.dismiss(animated: true, completion: nil)
        }
        
        actionSheet.addAction(okAction)
        actionSheet.addAction(noAction)
        actionSheet.addAction(cancelAction)
        present(actionSheet, animated: true, completion: nil)
    }
}



// MARK: - Post API

extension PostViewController {
    
    func plusPercentCount() {
        
        var urlString = ""
        
        switch type {
        case .contents: urlString = "/plus"
        case .movie: urlString = "/plus"
        case .tv: urlString = "/plus"
        }
        
        self.hud.show(in: self.view)
        
        let url = URL(string: baseUrl + urlString)!
        let params = ["id": value?.id ?? 0, "rank": 1] as Dictionary
        
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: ["Content-Type": "application/json"]).responseJSON { response in
            
            print("HTTP Body : " + String(decoding: response.request?.httpBody ?? Data(), as: UTF8.self))
            
            switch response.result {
            case .success(let data):
                
                let json = JSON(data)
                let result = json[0]["rank"].intValue
                
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
    
    
    func minusPercentCount() {
        
        var urlString = ""
        
//        switch type {
//        case .contents: urlString = "/drama"
//        case .movie: urlString = "/movie"
//        case .tv: urlString = "/tv"
//        }
        
        switch type {
        case .contents: urlString = "/plus"
        case .movie: urlString = "/plus"
        case .tv: urlString = "/plus"
        }
        
        self.hud.show(in: self.view)
        
        let url = URL(string: baseUrl + urlString)!
        let params = ["id": value?.id ?? 0, "rank": "Down"] as Dictionary
        
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: ["Content-Type": "application/json"]).responseJSON { response in
            
            print("HTTP Body : " + String(decoding: response.request?.httpBody ?? Data(), as: UTF8.self))
            
            switch response.result {
            case .success(let data):
                
                let json = JSON(data)
                let result = json[0]["rank"].intValue
                
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
}

//
//  PostVC.swift
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

class PostVC: UICollectionViewController {
    
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

extension PostVC {
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
            header.ValueViewModel = ValueVM(value: value)
        }

        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = PostReviewVC()
        let nav = UINavigationController(rootViewController: controller)
        nav.modalTransitionStyle = .crossDissolve
        present(nav, animated: true, completion: nil)
    }
}


// MARK: - UICollectionViewDelegateFlowLayout

extension PostVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 560)
    }
}

// MARK: - PostHeaderDelegate

extension PostVC: PostHeaderDelegate {
    
    func TapWish() {
        print("찜하기")
    }
    
    func didTapLike() {
        print("추천해요")
        
        AlertHelper.okAndNoHandlerAlert(title: "소중한 의견 감사해요!", message: "작품을 추천하는 이유를 리뷰로 남겨보시겠어요?", onConfirm: {
            self.plusPercentCount()
            let controller = WriteReviewVC()
            self.navigationController?.pushViewController(controller, animated: true)
        }, onCancel: {
            self.plusPercentCount()
            self.dismiss(animated: true, completion: nil)
        }, over: self)
        
    }
    
    func didTapUnLike() {
        print("별로예요")
        
        AlertHelper.okAndNoHandlerAlert(title: "소중한 의견 감사해요!", message: "작품이 별로였던 이유를 리뷰로 남겨보시겠어요?", onConfirm: {
            self.minusPercentCount()
            let controller = WriteReviewVC()
            self.navigationController?.pushViewController(controller, animated: true)
        }, onCancel: {
            self.minusPercentCount()
            self.dismiss(animated: true, completion: nil)
        }, over: self)
        
    }
}



// MARK: - Post API

extension PostVC {
    
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

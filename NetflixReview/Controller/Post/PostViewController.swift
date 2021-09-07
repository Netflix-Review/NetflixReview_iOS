//
//  PostViewController.swift
//  NetflixReview
//
//  Created by 강호성 on 2021/08/16.
//

enum Type {
    case drama
    case movie
    case tv
}

import UIKit
import Alamofire
import JGProgressHUD

class PostViewController: UICollectionViewController {
    
    // MARK: - Properties
    
    private let headerId = "PostHeader"
    private let cellId = "PostCell"
    
    var value: Value?
    
    private let baseUrl = "http://219.249.59.254:3000"
    
    var type: Type = .drama
    
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
                
        actionSheet.addAction(okAction)
        actionSheet.addAction(noAction)
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
        
        actionSheet.addAction(okAction)
        actionSheet.addAction(noAction)
        present(actionSheet, animated: true, completion: nil)
    }
}



// MARK: - Post API

extension PostViewController {
    
    func plusPercentCount() {
        
        var urlString = ""
        
        switch type {
        case .drama: urlString = "/plus"
        case .movie: urlString = "/plus"
        case .tv: urlString = "/plus"
        }
        
        self.hud.show(in: self.view)

        var request = URLRequest(url: URL(string: baseUrl + urlString)!)
        request.httpMethod = "POST"
        
//        print(value?.rank ?? 0)
//        value?.rank += 1
//        print(value?.rank ?? 0)
        
//        let params = ["rank": value?.rank ?? 0] as Dictionary
        let params = ["id": value?.id ?? 0, "rank": "추천"] as Dictionary
        
        DispatchQueue.main.async {
            // withJSONObject: JSON 데이터를 생성할 개체, options: JSON 데이터를 생성하기 위한 옵션
            // JSONSerialization = Dictionary -> JSON
            // 1. http 본문(추후 response 값)에 파라미터 객체를 JSON 데이터로 생성
            do {
                try request.httpBody = JSONSerialization.data(withJSONObject: params)
            } catch {
                print("http Body error")
            }
            
            // 2. AF.request(request) - 백단에 request를 송신, .responseString - 서버로부터 응답을 받기 위해 문자열로 처리한 후 서버에 전달
            // 서버로부터 응답을 받기 위한 메소드 - responseString: 응답결과를 문자열로 처리한 후 전달한다
            // 서버로부터 JSON 데이터를 응답받아서 문자열로 처리
            // 응답한 값을 response라는 변수에 담아주는 것
            AF.request(request).responseString { respone in
                // 4. respone.result 여기로 와서 성공이면 View에 값 업데이트
                switch respone.result {
                // 5. print 찍기
                case .success: print("POST 성공 \(params)")
                case .failure(let error): print("Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
                }
            }
            
            // 3. 요청한 데이터를 백단에서 반환한 데이터로 받아서 리로드
            self.collectionView.reloadData()
            self.hud.dismiss()
        }
    }
    
    func minusPercentCount() {
        
        var urlString = ""
        
        switch type {
        case .drama: urlString = "/drama"
        case .movie: urlString = "/movie"
        case .tv: urlString = "/tv"
        }
        
        self.hud.show(in: self.view)
        
        var request = URLRequest(url: URL(string: baseUrl + urlString)!)
        request.httpMethod = "POST"
        
//        print(value?.rank ?? 0)
//        value?.rank -= 1
//        print(value?.rank ?? 0)
        
        let params = ["id": value?.id ?? 0, "rank": "별로"] as Dictionary
        
        DispatchQueue.main.async {
            do {
                try request.httpBody = JSONSerialization.data(withJSONObject: params)
            } catch {
                print("http Body error")
            }
            
            AF.request(request).responseString { respone in
                switch respone.result {
                case .success: print("POST 성공 \(params)")
                case .failure(let error): print("Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
                }
            }
            self.collectionView.reloadData()
            self.hud.dismiss()
        }
    }
}

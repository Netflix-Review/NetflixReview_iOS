//
//  PostViewController.swift
//  NetflixReview
//
//  Created by 강호성 on 2021/08/16.
//

import UIKit

class PostViewController: UICollectionViewController {
    
    // MARK: - Properties
    
    private let headerId = "PostHeader"
    private let cellId = "PostCell"
    
    var contents: Contents?
    var movies: Movie?
    var tvprograms: tvProgram?
    
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
        
        
        if let contents = contents {
            header.ContentsViewModel = ContentsViewModel(contents: contents)
        }
        
        if let movies = movies {
            header.MovieViewModel = MovieViewModel(movie: movies)
        }
        
        if let tvprograms = tvprograms {
            header.TvProgramViewModel = TvProgramViewModel(tvprogram: tvprograms)
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
        
        let actionSheet = UIAlertController(title: "소중한 의견 감사해요 !", message: "작품을 추천하는 이유를 리뷰로 남겨보시겠어요?", preferredStyle: .actionSheet)
        let okAction = UIAlertAction(title: "리뷰 쓰러가기", style: .default) { _ in
            let controller = WriteReviewViewController()
            self.navigationController?.pushViewController(controller, animated: true)
        }
        let noAction = UIAlertAction(title: "다음에 할게요", style: .destructive, handler: nil)
        
        actionSheet.addAction(okAction)
        actionSheet.addAction(noAction)
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    func didTapUnLike() {
        print("별로예요")
        
        let actionSheet = UIAlertController(title: "소중한 의견 감사해요 !", message: "작품이 별로였던 이유를 리뷰로 남겨보시겠어요?", preferredStyle: .actionSheet)
        let okAction = UIAlertAction(title: "리뷰 쓰러가기", style: .default) { _ in
            let controller = WriteReviewViewController()
            self.navigationController?.pushViewController(controller, animated: true)
        }
        let noAction = UIAlertAction(title: "다음에 할게요", style: .destructive, handler: nil)
        
        actionSheet.addAction(okAction)
        actionSheet.addAction(noAction)
        
        present(actionSheet, animated: true, completion: nil)
    }
}

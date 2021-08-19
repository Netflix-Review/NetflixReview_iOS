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
        // height 크기 조정해야함
        return CGSize(width: view.frame.width, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        // height 크기 조정해야함
        return CGSize(width: view.frame.width, height: 500)
    }
}

// MARK: - PostHeaderDelegate

extension PostViewController: PostHeaderDelegate {
    func TapWish() {
        print("찜하기")
    }
    
    func didTapLike() {
        print("추천해요")
    }
    
    func didTapUnLike() {
        print("별로예요")
    }
}

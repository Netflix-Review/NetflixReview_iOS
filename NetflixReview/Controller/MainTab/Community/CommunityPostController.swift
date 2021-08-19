//
//  CommunityPostController.swift
//  NetflixReview
//
//  Created by 강호성 on 2021/08/17.
//

import UIKit

class CommunityPostController: UICollectionViewController {
   
    // MARK: - Properties
    
    private let cellId = "CommunityPostCell"
    private let headerId = "CommunityPostHeader"
    
    private lazy var coummunityInputView: CommunityInputAccesoryView = {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        
        let cv = CommunityInputAccesoryView(frame: frame)
        cv.delegate = self
        return cv
    }()
    
    var restoreFrameValue: CGFloat = 0.0
    
    // MARK: - Lifecycle
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        
        navigationController?.navigationBar.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        
        collectionView.register(CommunityPostCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(CommunityPostHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    
    override var inputAccessoryView: UIView? {
        get { return coummunityInputView }
    }
    
    // 키보드를 숨기고 표시하는 기능 제공
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.frame.origin.y = restoreFrameValue
        self.view.endEditing(true)
    }
    
    
    // MARK: - Action
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension CommunityPostController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CommunityPostCell
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! CommunityPostHeader
        return header
    }
}

// MARK: - UICollectionViewDataSource

extension CommunityPostController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // height 크기 조정해야함
        return CGSize(width: view.frame.width, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        // height 크기 조정해야함
        return CGSize(width: view.frame.width, height: 500)
    }
}

// MARK: - CommunityInputAccesoryViewDelegate

extension CommunityPostController: CommunityInputAccesoryViewDelegate {
    func inputView(_ inputView: CommunityInputAccesoryView, uploadComment comment: String) {
        print("upload comment")
        inputView.clearCommentTextView()
    }
    
    
}


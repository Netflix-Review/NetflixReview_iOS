//
//  CommunityViewController.swift
//  NetflixReview
//
//  Created by 강호성 on 2021/08/17.
//

import UIKit

class CommunityViewController: UICollectionViewController {
    
    // MARK: - Properties
    
    private let cellId = "CommunityCell"
    
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
        
        let search = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"),
                                     style: .plain, target: self, action: #selector(searchPost))
        
        let write = UIBarButtonItem(image: UIImage(systemName: "square.and.pencil"),
                                    style: .plain, target: self, action: #selector(writePost))
        navigationItem.rightBarButtonItems = [write, search]
        
        collectionView.register(CommunityCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.sizeToFit()
        navigationItem.title = "커뮤니티"
    }
    
    // MARK: - Action
    
    @objc func searchPost() {
        let controller = SeachCommunityPostController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func writePost() {
        let controller = AddCommunityPostController()
        navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension CommunityViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CommunityCell
        cell.layer.cornerRadius = 20
        cell.layer.shadowOpacity = 0.2
        cell.layer.shadowRadius = 10
        cell.layer.shadowOffset = .init(width: 0, height: -5)
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.backgroundColor = .systemBackground
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = CommunityPostController()
        let nav = UINavigationController(rootViewController: controller)
        nav.modalTransitionStyle = .crossDissolve
        present(nav, animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CommunityViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 15, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
}

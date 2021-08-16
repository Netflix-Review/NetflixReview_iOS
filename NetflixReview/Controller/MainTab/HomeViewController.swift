//
//  HomeViewController.swift
//  NetflixReview
//
//  Created by 강호성 on 2021/08/14.
//

import UIKit

class HomeViewController: UICollectionViewController {
    
    // MARK: - Properties
    
    private let cellId = "cellId"
    
    static let categoryHeaderId = "categoryHeaderId"
    let headerId = "headerId"
    
    // MARK: - Lifecycle
    
    init() {
        super.init(collectionViewLayout: HomeViewController.createLayout())
        collectionView.backgroundColor = .white
        collectionView.contentInset.top = 60
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class Header: UICollectionReusableView {
        let label = UILabel()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            label.text = "순위"
            label.font = UIFont.boldSystemFont(ofSize: 25)
            addSubview(label)
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            label.frame = bounds
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(Header.self, forSupplementaryViewOfKind: HomeViewController.categoryHeaderId, withReuseIdentifier: headerId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.sizeToFit()
        navigationItem.title = "홈"
    }
}

// MARK: - UICollectionViewCompositionalLayout

extension HomeViewController {
    static func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment -> NSCollectionLayoutSection? in
            
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.5),
                                                                heightDimension: .absolute(200)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 10)
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.7),
                                                                             heightDimension: .estimated(1000)),
                                                           subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 40, trailing: 0)
            section.orthogonalScrollingBehavior = .continuous
            
            section.boundarySupplementaryItems = [
                .init(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                        heightDimension: .absolute(25)),
                      elementKind: categoryHeaderId, alignment: .topLeading)
            ]
            
            return section
        }
        return layout
    }
}

// MARK: - UICollectionDatasource

extension HomeViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int { 4 }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath)
        return header

    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        cell.backgroundColor = .systemPink
        cell.layer.cornerRadius = 10
        return cell
    }
}

//
//  HomeViewController.swift
//  NetflixReview
//
//  Created by 강호성 on 2021/08/14.
//

import UIKit
import Alamofire

class HomeViewController: UICollectionViewController {
    
    // MARK: - Properties
    
    private let cellId = "HomeCell"
    let headerId = "HomeHeaderLabel"
    static let categoryHeaderId = "categoryHeaderId"
    
    private let moviewUrl = "http://219.249.59.254:3000"
    private var movies = [Movie]()
    
    private let photoUrl = "https://jsonplaceholder.typicode.com"
    private var photos = [Photo]()
    
    // MARK: - Lifecycle
    
    init() {
        super.init(collectionViewLayout: HomeViewController.createLayout())
        collectionView.backgroundColor = .white
        collectionView.contentInset.top = 40
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMovieData()
        fetchPhotpData()
        
        collectionView.register(HomeCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(HomeHeaderLabel.self, forSupplementaryViewOfKind: HomeViewController.categoryHeaderId, withReuseIdentifier: headerId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.sizeToFit()
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "Netflix Review"
    }
    
    // MARK: - Helpers
    
    func fetchMovieData() {
        AF.request(self.moviewUrl + "/netflix", method: .get).validate().responseDecodable(of: [Movie].self) { response in
            self.movies = response.value ?? []
            self.collectionView.reloadData()
        }
    }
    
    func fetchPhotpData() {
        AF.request(self.photoUrl + "/photos", method: .get).validate().responseDecodable(of: [Photo].self) { response in
            self.photos = response.value ?? []
            self.collectionView.reloadData()
        }
    }
}

// MARK: - UICollectionViewCompositionalLayout

extension HomeViewController {
    static func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment -> NSCollectionLayoutSection? in
            
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.5),
                                                                heightDimension: .absolute(200)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 10)
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1000)), subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 13, leading: 16, bottom: 40, trailing: 0)
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

// MARK: - UICollectionDatasource, UICollectionViewDelegate

extension HomeViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int { 3 }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! HomeHeaderLabel
        
        if indexPath.section == 0 {
            header.label.text = "영화 인기 콘텐츠"
        } else if indexPath.section == 1 {
            header.label.text = "드라마 인기 콘텐츠"
        } else if indexPath.section == 2 {
            header.label.text = "TV 프로그램 인기 콘텐츠"
        }
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section {
        case 0: return movies.count
        case 1: return photos.count
        case 2: return 4
        default: return 0
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomeCell
        cell.layer.cornerRadius = 10
        
        if indexPath.section == 0 {
            cell.movie = movies[indexPath.row]
        } else if indexPath.section == 1 {
            cell.photo = photos[indexPath.row]
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = PostViewController()
        
        if indexPath.section == 0 {
            controller.movies = movies[indexPath.row]
            print(movies[indexPath.row])
        } else if indexPath.section == 1 {
            controller.photos = photos[indexPath.row]
            print(photos[indexPath.row])
        }
        
        navigationController?.pushViewController(controller, animated: true)
    }
}

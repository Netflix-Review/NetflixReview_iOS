//
//  HomeVC.swift
//  NetflixReview
//
//  Created by 강호성 on 2021/08/14.
//

import UIKit
import Alamofire
import JGProgressHUD

class HomeVC: UICollectionViewController {
    
    // MARK: - Properties
    
    private let cellId = "HomeCell"
    let headerId = "HomeHeaderLabel"
    static let categoryHeaderId = "categoryHeaderId"
    
    private let baseUrl = "http://61.254.56.218:3000"
    private var contents = [Value]()
    private var movies = [Value]()
    private var tvprograms = [Value]()
    
    let hud = JGProgressHUD(style: .dark)

    // MARK: - Lifecycle
    
    init() {
        super.init(collectionViewLayout: HomeVC.createLayout())
        collectionView.backgroundColor = .white
        collectionView.contentInset.top = 40
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchContentsData()
        fetchMovieData()
        fetchTvData()
        
        collectionView.contentInset.bottom = 50
        collectionView.register(HomeCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(HomeHeaderLabel.self, forSupplementaryViewOfKind: HomeVC.categoryHeaderId, withReuseIdentifier: headerId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "Netflix Review"
    }
    
    // MARK: - FetchAPI
    
    func fetchContentsData() {
        AF.request(self.baseUrl + "/drama", method: .get).validate().responseDecodable(of: [Value].self) { response in
            self.contents = response.value ?? []
            self.collectionView.reloadData()
        }
    }
    
    func fetchMovieData() {
        AF.request(self.baseUrl + "/movie", method: .get).validate().responseDecodable(of: [Value].self) { response in
            self.movies = response.value ?? []
            self.collectionView.reloadData()
        }
    }
    
    func fetchTvData() {
        AF.request(self.baseUrl + "/tv", method: .get).validate().responseDecodable(of: [Value].self) { response in
            self.tvprograms = response.value ?? []
            self.collectionView.reloadData()
        }
    }
}


// MARK: - UICollectionViewCompositionalLayout

extension HomeVC {
    static func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment -> NSCollectionLayoutSection? in
            
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.5),
                                                                heightDimension: .absolute(180)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 10)
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.7), heightDimension: .estimated(1000)), subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 13, leading: 16, bottom: 60, trailing: 0)
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

extension HomeVC {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int { 3 }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! HomeHeaderLabel
        
        if indexPath.section == 0 {
            header.label.text = "한국의 TOP 10 콘텐츠"
        } else if indexPath.section == 1 {
            header.label.text = "영화 TOP 10"
        } else if indexPath.section == 2 {
            header.label.text = "TV 프로그램 TOP 10"
        }
        header.label.textColor = .black
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section {
        case 0: return contents.count
        case 1: return movies.count
        case 2: return tvprograms.count
        default: return 0
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomeCell
        cell.layer.cornerRadius = 10
        
        if indexPath.section == 0 {
            cell.contents = contents[indexPath.row]
        } else if indexPath.section == 1 {
            cell.movie = movies[indexPath.row]
        } else if indexPath.section == 2 {
            cell.tvprogram = tvprograms[indexPath.row]
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = PostVC()
       
        if indexPath.section == 0 {
            controller.value = contents[indexPath.row]
        } else if indexPath.section == 1 {
            controller.value = movies[indexPath.row]
        } else if indexPath.section == 2 {
            controller.value = tvprograms[indexPath.row]
        }
        
        navigationController?.pushViewController(controller, animated: true)
    }
}

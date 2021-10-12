//
//  ProfileVC.swift
//  NetflixReview
//
//  Created by 강호성 on 2021/08/14.
//

import UIKit
import Alamofire

class ProfileVC: UICollectionViewController {
    
    // MARK: - Properties
    
    private let baseUrl = "http://219.249.59.254:3000"
    
    private let cellId = "ProfileWishCell"
    private let headerId = "ProfileHeader"
    
    private var selectedFilter: HeaderFIlterOptions = .Wish {
        didSet { collectionView.reloadData() }
    }
        
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
        checkToken()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.fill.xmark"), style: .plain, target: self, action: #selector(logout))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.sizeToFit()
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "안녕하세요"
    }
    
    // MARK: - Helpers
    
    func checkToken() {
        let tk = TokenUtils()
        
        if let accessToken = tk.load(baseUrl + "/api/login", account: "accessToken") {
            print("프로필에서 액세스 토큰 확인 = \(accessToken)")
        } else {
            print("accessToken is nil,,,")
        }
        
        if let username = tk.load(baseUrl + "/api/login", account: "username") {
            print("프로필에서 유저네임 확인 = \(username)")
        } else {
            print("username is nil,,,")
        }
    }
    
    
    func configureCollectionView() {
        collectionView.backgroundColor = .white
        
        collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(ProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
    }
    
    // MARK: - Action
    
    @objc func logout() {
        // 알림
        
        let url = URL(string: baseUrl + "/api/login")!
        let tk = TokenUtils()
        tk.delete("\(url)", account: "accessToken")
        
        // 로그아웃 후 화면전환
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension ProfileVC {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ProfileCell
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! ProfileHeader
        
        header.delegate = self
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = PostVC()
        navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ProfileVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return -10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 5) / 3
        return CGSize(width: width, height: 180)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 150)
    }
}

// MARK: - FeedHeaderDelegate

extension ProfileVC: ProfileHeaderDelegate {
    
    func didSelect(filter: HeaderFIlterOptions) {
        self.selectedFilter = filter
    }
    
    func editName() {
        let controller = EditInfoVC()
        navigationController?.pushViewController(controller, animated: true)
    }
}

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
        
    let tk = TokenUtils()
    
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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.fill.xmark"), style: .plain, target: self, action: #selector(logout))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.sizeToFit()
        navigationItem.title = "안녕하세요"
        
        collectionView.reloadData()
    }
    
    // MARK: - Helpers
    
    func configureCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(ProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
    }
    
    // MARK: - Action
    
    @objc func logout() {

        let url = URL(string: baseUrl + "/api/login")!
        
        let alertSheet = UIAlertController(title: "로그아웃 하시겠습니까?",
                                            message: nil,
                                            preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "확인", style: .default) { _ in
            self.tk.delete("\(url)", account: "accessToken")
        }
        
        let noAction = UIAlertAction(title: "취소", style: .default, handler: nil)
        
        alertSheet.addAction(okAction)
        alertSheet.addAction(noAction)
        self.present(alertSheet, animated: true, completion: nil)
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
        
        let userName = tk.load(baseUrl + "/api/login", account: "username")
        header.nameLabel.text = "\(userName ?? "")님"
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
        return 1
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

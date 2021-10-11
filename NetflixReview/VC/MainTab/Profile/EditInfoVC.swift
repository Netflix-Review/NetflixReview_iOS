//
//  EditInfoVC.swift
//  NetflixReview
//
//  Created by 강호성 on 2021/08/30.
//

import UIKit
import Alamofire

class EditInfoVC: UICollectionViewController {
    
    // MARK: - Properties
    
    private let cellId = "EditInfoCell"
    
    let tk = TokenUtils()
    private let baseUrl = "http://219.249.59.254:3000"
    
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
        collectionView.register(EditInfoCell.self, forCellWithReuseIdentifier: cellId)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.fill.checkmark"), style: .plain, target: self, action: #selector(updataUserInfo))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.sizeToFit()
        navigationItem.title = "이름 변경"
    }
    
    // MARK: - Action
    
    @objc func updataUserInfo() {
        print("업데이트")
        
        let token = tk.load(baseUrl + "/api/login", account: "accessToken")
        let params = ["token": token ?? ""]
        print(params)
        
        let url = URL(string: baseUrl + "/api/auth")!
                
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: ["Content-Type": "application/json"]).responseJSON { response in
            
            switch response.result {
            case .success(let data):
                print("이름 변경 post 성공, \(data)")
            case .failure(let error):
                print("Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
            }
        }
    }
    
}

// MARK: - DataSource

extension EditInfoVC {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! EditInfoCell
        
        cell.layer.cornerRadius = 20
        cell.layer.shadowOpacity = 0.2
        cell.layer.shadowRadius = 10
        cell.layer.shadowOffset = .init(width: 0, height: -5)
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.backgroundColor = .white
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension EditInfoVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 30, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
}

//
//  EditInfoVC.swift
//  NetflixReview
//
//  Created by 강호성 on 2021/08/30.
//

import UIKit

class EditInfoVC: UICollectionViewController {
    
    // MARK: - Properties
    
    private let cellId = "EditInfoCell"
    
    // MARK: - Lifecycle
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .systemGroupedBackground
        
        collectionView.register(EditInfoCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.sizeToFit()
        navigationItem.title = "이름 변경"
    }
    
    
}

// MARK: - DataSource

extension EditInfoVC {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return EditNameOption.allCases.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! EditInfoCell
        
        cell.layer.cornerRadius = 20
        cell.layer.shadowOpacity = 0.2
        cell.layer.shadowRadius = 10
        cell.layer.shadowOffset = .init(width: 0, height: -5)
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.backgroundColor = .systemBackground
        
        guard let option = EditNameOption(rawValue: indexPath.row) else { return cell }
        cell.viewModel = EditNameVM(option: option)
        
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

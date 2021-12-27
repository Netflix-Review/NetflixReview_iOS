//
//  HeaderFilterView.swift
//  NetflixReview
//
//  Created by 강호성 on 2021/08/16.
//

import UIKit

protocol HeaderFilterViewDelegate: AnyObject {
    func filterView(_ view: HeaderFilterView, didSelect index: Int)
}

class HeaderFilterView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: HeaderFilterViewDelegate?
    
    private let cellId = "HeaderFilterCollectionViewCell"
    
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.backgroundColor = .white
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    private let underLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPink
        return view
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionView.register(HeaderFilterCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        let selectedFirst = IndexPath(row: 0, section: 0)
        collectionView.selectItem(at: selectedFirst, animated: true, scrollPosition: .left)
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        // shadow 효과
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 10
        layer.shadowOffset = .init(width: 0, height: -5)
        layer.shadowColor = UIColor.lightGray.cgColor
    }

    override func layoutSubviews() {
        addSubview(underLineView)
        underLineView.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview()
            make.width.equalTo(frame.width / 2)
            make.height.equalTo(2)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension HeaderFilterView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return HeaderFIlterOptions.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HeaderFilterCollectionViewCell
        
        let option = HeaderFIlterOptions(rawValue: indexPath.row)
        cell.option = option
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath)
        let xPosition = cell?.frame.origin.x ?? 0
        UIView.animate(withDuration: 0.1) { self.underLineView.frame.origin.x = xPosition }
        
        delegate?.filterView(self, didSelect: indexPath.row)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension HeaderFilterView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 2, height: frame.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

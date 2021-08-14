//
//  HomeViewController.swift
//  NetflixReview
//
//  Created by 강호성 on 2021/08/14.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureNavigationBar()
    }
    
    // MARK: - Helpers
    
    func configureNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "홈"
    }
}

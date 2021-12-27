//
//  MainTabBarController.swift
//  NetflixReview
//
//  Created by 강호성 on 2021/08/14.
//

import UIKit
import Alamofire

class MainTabBarController: UITabBarController {
    
    // MARK: - Properties
    
    let tk = TokenUtils()
    private let baseUrl = "http://61.254.56.218:3000"
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.barTintColor = .white
        tabBar.isTranslucent = true
        
        checkLoginedUser()
//        configureViewControllers()
    }
    
    // MARK: - Helpers
    
    func checkLoginedUser() {
        
        let token = tk.load(baseUrl + "/api/login", account: "accessToken")
        
        if ((token?.isEmpty) == nil) {
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginViewController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        } else {
            configureViewControllers()
        }
    }
    
    func configureViewControllers() {
        let home = templateNavigationController(image: UIImage(systemName: "house")!, title: "홈", rootViewController: HomeCollectionViewController())
        let explore = templateNavigationController(image: UIImage(systemName: "antenna.radiowaves.left.and.right")!, title: "탐색", rootViewController: ExploreViewController())
        let new = templateNavigationController(image: UIImage(systemName: "rectangle.on.rectangle.angled")!, title: "신규", rootViewController: NewCollectionViewController())
        let profile = templateNavigationController(image: UIImage(systemName: "person")!, title: "프로필", rootViewController: ProfileCollectionViewController())
        
        viewControllers = [home, explore, new, profile]
    }
    
    func templateNavigationController(image: UIImage, title: String, rootViewController: UIViewController) -> UINavigationController {
        
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = image
        nav.tabBarItem.title = title
        nav.navigationBar.tintColor = .black
        return nav
    }
}

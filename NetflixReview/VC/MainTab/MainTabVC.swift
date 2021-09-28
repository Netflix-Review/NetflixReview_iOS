//
//  MainTabVC.swift
//  NetflixReview
//
//  Created by 강호성 on 2021/08/14.
//

import UIKit

class MainTabVC: UITabBarController {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewControllers()
        tabBarColor()
    }
    
    // MARK: - Helpers
    
    func tabBarColor() {
        tabBar.barTintColor = .white
        tabBar.isTranslucent = false
    }
    
    func configureViewControllers() {
        let home = templateNavigationController(image: UIImage(systemName: "house")!, title: "홈", rootViewController: HomeVC())
        let explore = templateNavigationController(image: UIImage(systemName: "antenna.radiowaves.left.and.right")!, title: "탐색", rootViewController: ExploreVC())
        let community = templateNavigationController(image: UIImage(systemName: "heart.text.square")!, title: "커뮤니티", rootViewController: CommunityVC())
        let profile = templateNavigationController(image: UIImage(systemName: "person")!, title: "프로필", rootViewController: ProfileVC())
        
        viewControllers = [home, explore, community, profile]
    }
    
    func templateNavigationController(image: UIImage, title: String, rootViewController: UIViewController) -> UINavigationController {
        
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = image
        nav.tabBarItem.title = title
        nav.navigationBar.tintColor = .black
        return nav
    }
}

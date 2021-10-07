//
//  MainTabVC.swift
//  NetflixReview
//
//  Created by 강호성 on 2021/08/14.
//

import UIKit
import Alamofire

class MainTabVC: UITabBarController {
    
    // MARK: - Properties
    
    var isLogin: Bool = false
    private let baseUrl = "http://219.249.59.254:3000"
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.barTintColor = .white
        tabBar.isTranslucent = true
        
        checkLoginedUser()
        checkToken()
    }
    
    // MARK: - Helpers
    
    func checkToken() {
        let tk = TokenUtils()
        if let accessToken = tk.load(baseUrl + "/api/login", account: "accessToken") {
            print("메인탭에서 액세스 토큰 확인 = \(accessToken)")
        } else {
            print("accessToken is nil,,,")
        }
    }
    
    func checkLoginedUser() {
                
        if isLogin == false {
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginVC())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        } else {
            configureViewControllers()
        }
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

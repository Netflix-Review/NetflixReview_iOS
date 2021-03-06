//
//  SceneDelegate.swift
//  NetflixReview
//
//  Created by 강호성 on 2021/08/14.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        
//        window?.rootViewController = UINavigationController(rootViewController: LoginVC())
        window?.rootViewController = MainTabBarController()
        window?.makeKeyAndVisible()
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {

    }
}


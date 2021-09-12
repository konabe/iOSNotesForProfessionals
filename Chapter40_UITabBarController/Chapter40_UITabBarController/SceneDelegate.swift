//
//  SceneDelegate.swift
//  Chapter40_UITabBarController
//
//  Created by 小鍋涼太 on 2021/09/11.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    let isSetInSceneDelegate = false // SceneDelegateで設定するパターン
    
    var firstTabNavigationController: UINavigationController!
    var secondTabNavigationController: UINavigationController!
    var thirdTabNavigationController: UINavigationController!
    var fourthTabNavigationController: UINavigationController!
    var fifthTabNavigationController: UINavigationController!

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        // §40.5 Create Tab Bar controller programmatically without Storyboard
        window = UIWindow(windowScene: scene)
        window?.backgroundColor = .black
        let tabBarController = TabBarController()
        if isSetInSceneDelegate {
            tabBarController.view.backgroundColor = .white
            firstTabNavigationController = UINavigationController(rootViewController: FirstViewController())
            secondTabNavigationController = UINavigationController(rootViewController: SecondViewController())
            thirdTabNavigationController = UINavigationController(rootViewController: ThirdViewController())
            fourthTabNavigationController = UINavigationController(rootViewController: FourthViewController())
            fifthTabNavigationController = UINavigationController(rootViewController: FifthViewController())
            tabBarController.viewControllers = [
                firstTabNavigationController, secondTabNavigationController, thirdTabNavigationController,
                fourthTabNavigationController, fifthTabNavigationController
            ]
            let item1 = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
            let item2 = UITabBarItem(title: "Contest", image: UIImage(systemName: "pencil.slash"), tag: 1)
            let item3 = UITabBarItem(title: "Post a Picture", image: UIImage(systemName: "photo"), tag: 2)
            let item4 = UITabBarItem(title: "Prizes", image: UIImage(systemName: "bitcoinsign.circle"), tag: 3)
            let item5 = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle"), tag: 4)
            firstTabNavigationController.tabBarItem = item1
            secondTabNavigationController.tabBarItem = item2
            thirdTabNavigationController.tabBarItem = item3
            fourthTabNavigationController.tabBarItem = item4
            fifthTabNavigationController.tabBarItem = item5
            UITabBar.appearance().tintColor = .cyan
        }
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}


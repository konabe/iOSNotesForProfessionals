//
//  ViewController.swift
//  Chapter40_UITabBarController
//
//  Created by 小鍋涼太 on 2021/09/11.
//

import UIKit

// Chapter40 UITabBarController

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // §40.1 Create an instance
        // §40.2 Navigation Controller with TabBar
        // §40.3 Tab Bar color cusotmizing
        UITabBar.appearance().tintColor = .white
        UITabBar.appearance().barTintColor = .red
        UINavigationBar.appearance().barTintColor = .green
        UINavigationBar.appearance().tintColor = .purple
        
        // §40.4 Changing Tab Bar Item Title and Icon
        
        // §40.5 Create Tab Bar controller programmatically without Storyboard
        // SceneDelegate.swiftにて。
        // MARK: SceneDelegateがある状態だと、UIApplicationDelegate上でUIWindowを保持していても意味がなくなるので注意。
        
        // §40.6
        setProgramatically()
        UITabBar.appearance().barTintColor = .black
        
        navigationController?.isNavigationBarHidden = true
        UITabBar.appearance().tintColor = .purple
        let numberOfItems = CGFloat(tabBar.items!.count)
        let tabBarItemSize = CGSize(width: tabBar.frame.width / numberOfItems, height: tabBar.frame.height)
        tabBar.selectionIndicatorImage = .imageWithColor(.lightText.withAlphaComponent(0.5), size: tabBarItemSize).resizableImage(withCapInsets: UIEdgeInsets(top: -10, left: 0, bottom: 5, right: 0))
        tabBar.frame.size.width = view.frame.width + 4
        tabBar.frame.origin.x -= 2
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    private func setProgramatically() {
        let firstTabNavigationController = UINavigationController(rootViewController: FirstViewController())
        let secondTabNavigationController = UINavigationController(rootViewController: SecondViewController())
        let thirdTabNavigationController = UINavigationController(rootViewController: ThirdViewController())
        let fourthTabNavigationController = UINavigationController(rootViewController: FourthViewController())
        let fifthTabNavigationController = UINavigationController(rootViewController: FifthViewController())
        viewControllers = [
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
    }

}

extension UIImage {
    class func imageWithColor(_ color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: size.width, height: size.height))
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}

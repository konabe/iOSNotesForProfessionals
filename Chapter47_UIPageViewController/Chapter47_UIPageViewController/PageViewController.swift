//
//  PageViewController.swift
//  Chapter47_UIPageViewController
//
//  Created by 小鍋涼太 on 2021/09/16.
//

import UIKit

// §47.2 A simple way to create horizontal page view controllers (infinite pages)
class PageViewController: UIPageViewController, UIPageViewControllerDataSource {
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        let controller = createViewController()
        setViewControllers([controller], direction: .forward, animated: false, completion: nil)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        createViewController()
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        createViewController()
    }
    
    func createViewController() -> UIViewController {
        let randomcolor = UIColor(hue: CGFloat(arc4random_uniform(360))/360, saturation: 0.5, brightness: 0.8, alpha: 1)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(identifier: "viewController")
        controller.view.backgroundColor = randomcolor
        return controller
    }
    
}

//
//  ViewController.swift
//  Chapter47_UIPageViewController
//
//  Created by 小鍋涼太 on 2021/09/14.
//

import UIKit

// Chapter47 UIPageViewController
// スワイプジェスチャーで遷移する
// UIPageViewControllerDataSourceのメソッドを実装する必要がある

class ViewController: UIViewController {

    var viewControllers = [UIViewController]()
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // TODO: うまくいかないので調査
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // §47.1 Create a horizontal paging UIPageViewController programmatically
        let firstVC = PagedViewController()
        firstVC.identifier = 0
        let secondVC = PagedViewController()
        secondVC.identifier = 1
        viewControllers = [firstVC, secondVC]
        let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.dataSource = self
        if !viewControllers.isEmpty {
            pageViewController.setViewControllers(viewControllers, direction: .forward, animated: false, completion: nil)
        }
        addChild(pageViewController)
        pageViewController.view.frame = view.frame
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
    }

}

extension ViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        viewControllers[0]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        viewControllers[1]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        viewControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        index
    }
    
}

class PagedViewController: UIViewController {
    var identifier: Int!
}

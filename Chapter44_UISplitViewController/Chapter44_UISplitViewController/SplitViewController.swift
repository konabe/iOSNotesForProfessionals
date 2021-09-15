//
//  SplitViewController.swift
//  Chapter44_UISplitViewController
//
//  Created by 小鍋涼太 on 2021/09/13.
//

import UIKit

class SplitViewController: UISplitViewController {
    private var masterVC: MasterViewController!
    private var detailVC: DetailViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        masterVC = UIStoryboard(name: "ViewControllers", bundle: nil).instantiateViewController(identifier: "masterViewController") as MasterViewController
        detailVC = UIStoryboard(name: "ViewControllers", bundle: nil).instantiateViewController(identifier: "detailViewController") as DetailViewController
        masterVC.detailDelegate = detailVC
        preferredDisplayMode = .automatic
        viewControllers = [masterVC, detailVC]
        presentsWithGesture = true
    }
}

protocol DetailViewDelegate: AnyObject {
    func sendSelectedNavController(viewController: UIViewController)
}

class MasterViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView! {
        willSet {
            newValue.delegate = self
            newValue.dataSource = self
        }
    }
    var detailDelegate: DetailViewDelegate?
    var vcArray = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let detailVC = UIStoryboard(name: "ViewControllers", bundle: nil).instantiateViewController(identifier: "detailViewController") as DetailViewController
        vcArray.append(detailVC)
        let dashBoardVC = UIStoryboard(name: "ViewControllers", bundle: nil).instantiateViewController(identifier: "dashBoardViewController") as DashBoardViewController
        vcArray.append(dashBoardVC)
        let detailVC2 = UIStoryboard(name: "ViewControllers", bundle: nil).instantiateViewController(identifier: "detailViewController") as DetailViewController
        vcArray.append(detailVC2)
        let dashBoardVC2 = UIStoryboard(name: "ViewControllers", bundle: nil).instantiateViewController(identifier: "dashBoardViewController") as DashBoardViewController
        vcArray.append(dashBoardVC2)
    }
}

extension MasterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        vcArray.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
}

extension MasterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        detailDelegate?.sendSelectedNavController(viewController: vcArray[indexPath.row])
    }
    
}

class DetailViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }
}

extension DetailViewController: DetailViewDelegate {
    func sendSelectedNavController(viewController: UIViewController) {
        let viewsToRemove = view.subviews
        for v in viewsToRemove {
            v.removeFromSuperview()
        }
        let tempVC = viewController
        view.addSubview(tempVC.view)
    }
}

class DashBoardViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
    }
}




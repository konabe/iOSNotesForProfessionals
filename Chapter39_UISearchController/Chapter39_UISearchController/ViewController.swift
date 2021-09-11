//
//  ViewController.swift
//  Chapter39_UISearchController
//
//  Created by 小鍋涼太 on 2021/09/11.
//

import UIKit

// Chapter39 UISearchController

class ViewController: UITableViewController {

    let entries = ["Easiest", "Intermediate", "Advanced", "Expert Only"]
    var searchResults = [String]()
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // §39.1 Search Bar in Navigation Bar Title
        searchController.searchResultsUpdater = self
        definesPresentationContext = true
        // 39.2でこれがあると意味がなくなる。
        //navigationItem.titleView = searchController.searchBar
        //searchController.hidesNavigationBarDuringPresentation = false
        
        // §39.2 Search Bar in Table View Header
        // §39.3 Implementation
        tableView.tableHeaderView = searchController.searchBar
        // 最初にサーチバーが見えないようにする
        tableView.contentOffset = CGPoint(x: 0, y: searchController.searchBar.frame.height)
        
        // §39.4 UISearchController in Objective-C
        searchController.searchBar.backgroundColor = .blue
        searchController.searchBar.tintColor = .green
        searchController.searchBar.delegate = self
    }
    
    private func filterContent(for searchText: String) {
        searchResults = entries.filter { e -> Bool in
            let match = e.range(of: searchText, options: .caseInsensitive)
            return match != nil
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchController.isActive ? searchResults.count : entries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let entry = searchController.isActive ? searchResults[indexPath.row] : entries[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "testCell", for: indexPath)
        cell.textLabel?.text = entry
        return cell
    }
}

extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContent(for: searchText)
            tableView.reloadData()
        }
    }

}

extension ViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        navigationController?.navigationBar.backgroundColor = .red
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        navigationController?.navigationBar.backgroundColor = .green
    }
}

//
//  SeachCommunityPostVC.swift
//  NetflixReview
//
//  Created by 강호성 on 2021/08/19.
//

import UIKit
import SnapKit

class SeachCommunityPostVC: UITableViewController {
    
    // MARK: - Properties
    
    private let cellId = "SeachCommunityPostCell"
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var inSearchMode: Bool {
        return searchController.isActive && !searchController.searchBar.text!.isEmpty
    }
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureTableView()
        configureSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.hidesSearchBarWhenScrolling = true
        searchController.isActive = true
    }
    
    // 키보드를 숨기고 표시하는 기능 제공
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    // MARK: - Helpers
    
    func configureTableView() {
        tableView.register(SeachCommunityPostCell.self, forCellReuseIdentifier: cellId)
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 100
    }
    
    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchBar.placeholder = "검색어를 입력하세요"
        navigationItem.searchController = searchController
        definesPresentationContext = false
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension SeachCommunityPostVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! SeachCommunityPostCell
        cell.backgroundColor = .white
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UISearchResultsUpdating
// 검색결과 업데이트

extension SeachCommunityPostVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard (searchController.searchBar.text?.lowercased()) != nil else { return }
        
        self.tableView.reloadData()
    }
}

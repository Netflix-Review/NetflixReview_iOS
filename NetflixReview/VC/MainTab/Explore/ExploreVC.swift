//
//  ExploreVC.swift
//  NetflixReview
//
//  Created by 강호성 on 2021/08/14.
//

import UIKit

class ExploreVC: UIViewController {
    
    // MARK: - Properties
    
    private let tableView = UITableView()
    private let cellId = "VideoListCell"
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var inSearchMode: Bool {
        return searchController.isActive && !searchController.searchBar.text!.isEmpty
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        configureSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.sizeToFit()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationItem.hidesSearchBarWhenScrolling = true
        searchController.isActive = true
    }

    // 키보드를 숨기고 표시하는 기능 제공
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    // MARK: - Helpers
    
    func configureTableView() {
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(VideoListCell.self, forCellReuseIdentifier: cellId)
        tableView.rowHeight = 120
        tableView.separatorStyle = .none
        
        view.addSubview(tableView)
        tableView.frame = view.frame
        tableView.contentInset.top = 10
        tableView.tableFooterView = UIView()
    }
    
    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchBar.placeholder = "작품, 컬렉션, 감독, 배우 등"
        navigationItem.searchController = searchController
        definesPresentationContext = false
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension ExploreVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! VideoListCell
        cell.backgroundColor = .white
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("tap")
    }
}

// MARK: - UISearchResultsUpdating
// 검색결과 업데이트

extension ExploreVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard (searchController.searchBar.text?.lowercased()) != nil else { return }
        
        self.tableView.reloadData()
    }
}
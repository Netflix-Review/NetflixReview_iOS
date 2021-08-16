//
//  ExploreViewController.swift
//  NetflixReview
//
//  Created by 강호성 on 2021/08/14.
//

import UIKit

class ExploreViewController: UIViewController {
    
    // MARK: - Properties
    
    private let tableView = UITableView()
    private let cellId = "VideoListCell"
    
    private let seacrhController = UISearchController(searchResultsController: nil)
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureTableView()
        configureSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.sizeToFit()
        navigationItem.title = "탐색"
    }
    
    
    // MARK: - Helpers
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(VideoListCell.self, forCellReuseIdentifier: cellId)
        tableView.rowHeight = 64
        
        view.addSubview(tableView)
        tableView.frame = view.frame
        tableView.tableFooterView = UIView()
    }
    
    func configureSearchController() {
        seacrhController.searchResultsUpdater = self
        seacrhController.obscuresBackgroundDuringPresentation = false
        seacrhController.hidesNavigationBarDuringPresentation = true
        seacrhController.searchBar.placeholder = "작품, 컬렉션, 감독, 배우 등"
        navigationItem.searchController = seacrhController
        definesPresentationContext = false
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension ExploreViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! VideoListCell
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("tap")
    }
}

// MARK: - UISearchResultsUpdating
// 검색결과 업데이트

extension ExploreViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased() else { return }
        print("DEBUG: Search text \(searchText)")
        
        self.tableView.reloadData()
    }
}

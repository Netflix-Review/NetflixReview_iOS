//
//  ExploreVC.swift
//  NetflixReview
//
//  Created by 강호성 on 2021/08/14.
//

import UIKit
import Alamofire
import SwiftyJSON

class ExploreVC: UIViewController {
    
    // MARK: - Properties
    
    private let tableView = UITableView()
    private let cellId = "VideoListCell"
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var inSearchMode: Bool {
        return searchController.isActive && !searchController.searchBar.text!.isEmpty
    }
        
    private var value = [Value]() {
        didSet { tableView.reloadData() }
    }
    
    private let baseUrl = "http://61.254.56.218:3000"
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]

        configureTableView()
        configureSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.sizeToFit()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationItem.hidesSearchBarWhenScrolling = true
        searchController.isActive = true
    }
    
    // MARK: - Helpers
    
    func configureTableView() {
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(VideoListCell.self, forCellReuseIdentifier: cellId)
        tableView.rowHeight = 110
        tableView.separatorStyle = .none
        
        view.addSubview(tableView)
        tableView.frame = view.frame
        tableView.contentInset.top = 10
        tableView.contentInset.bottom = 50
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
        return value.count
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
        let searchText = searchController.searchBar.text?.lowercased() ?? ""
        let param = ["text": searchText] as Dictionary
        
        AF.request(baseUrl + "/search", method: .post, parameters: param, encoding: JSONEncoding.default, headers: ["Content-Type": "application/json"]).responseJSON { response in

            switch response.result {
            case .success(let data):
                print("성공 \(param), \(data)")
                
                let json = JSON(data)
                print(json.count)
                print("json[1]  \(json[1][0]["title"]), \(json[1])")
                
            case .failure(let error):
                print("Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
            }
        }
    }
}

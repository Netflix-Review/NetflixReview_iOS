//
//  ExploreViewController.swift
//  NetflixReview
//
//  Created by 강호성 on 2021/08/14.
//

import UIKit
import Alamofire
import SwiftyJSON

class ExploreViewController: UIViewController {
    
    // MARK: - Properties
    
    private let tableView = UITableView()
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var inSearchMode: Bool {
        return searchController.isActive && !searchController.searchBar.text!.isEmpty
    }
        
    private var value = [Value]() {
        didSet { tableView.reloadData() }
    }
        
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
        tableView.register(VideoListTableViewCell.self, forCellReuseIdentifier: UITableViewCell.reuseIdentifier)
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

extension ExploreViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reuseIdentifier, for: indexPath) as! VideoListTableViewCell
        cell.backgroundColor = .white
        
        let row = value[indexPath.row]
        cell.postImageView.setImage(imageUrl: row.post)
        cell.videoLabel.text = row.title
        cell.infoLabel.text = row.info
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = PostCollectionViewController()
        vc.value = value[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UISearchResultsUpdating
// 검색결과 업데이트

extension ExploreViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text?.lowercased() ?? ""
        let param = ["text": searchText] as Dictionary
        var tmp = [Value]()
        
        if searchText.isEmpty {
            print("비어있음")
            value = []
        } else {
            AF.request(URL.baseURL + "/search", method: .post, parameters: param, encoding: JSONEncoding.default, headers: ["Content-Type": "application/json"]).responseJSON { response in
                
                switch response.result {
                case .success(let data):
                    
                    let json = JSON(data)
                    
                    for item in json.arrayValue {
                        let id = item[0]["id"].intValue
                        let title = item[0]["title"].stringValue
                        let info = item[0]["info"].stringValue
                        let post = item[0]["post"].stringValue
                        let view = item[0]["view"].stringValue
                        let des = item[0]["des"].stringValue
                        let rank = item[0]["rank"].intValue
                        let list = item[0]["list"].intValue
                        
                        
                        let value = Value(id: id, title: title, post: post, view: view, info: info, des: des, rank: rank, list: list)
                        
                        if item != [] { tmp.append(value) }
                        
                        DispatchQueue.main.async {
                            self.value = tmp
                        }
                    }
                    
                case .failure(let error):
                    print("Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
                }
            }
        }
        
    }
}

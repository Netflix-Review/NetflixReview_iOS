//
//  ExploreVC.swift
//  NetflixReview
//
//  Created by 강호성 on 2021/08/14.
//

import UIKit
import Alamofire

class ExploreVC: UIViewController {
    
    // MARK: - Properties
    
    private let tableView = UITableView()
    private let cellId = "VideoListCell"
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var inSearchMode: Bool {
        return searchController.isActive && !searchController.searchBar.text!.isEmpty
    }
        
    private var data = [Value]() {
        didSet { tableView.reloadData() }
    }
    
    private var filterData = [Value]() {
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
        fetchTotalData()
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
    
    // 첫 테이블 Cell에 띄울 데이터
    func fetchTotalData() {
        AF.request(self.baseUrl, method: .get).validate().responseDecodable(of: [Value].self) { response in
            self.data = response.value ?? []
            self.tableView.reloadData()
        }
    }
    
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
        return 10
//        return inSearchMode ? filterData.count : data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! VideoListCell
        cell.backgroundColor = .white
        
//        let value = inSearchMode ? filterData[indexPath.row] : data[indexPath.row]
//        cell.value = value
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("tap")
        
//        let vc = PostVC()
//        vc.value = data[indexPath.row]
//        navigationController?.pushViewController(vc, animated: true)
    }
    
}

// MARK: - UISearchResultsUpdating
// 검색결과 업데이트

extension ExploreVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text?.lowercased() ?? ""
        let trimText = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        let param = ["text": trimText] as Dictionary
        
        print("trimText: \(trimText), \(param)")
        
        AF.request(baseUrl + "/search", method: .post, parameters: param, encoding: JSONEncoding.default, headers: ["Content-Type": "application/json"]).responseJSON { response in

            switch response.result {
            case .success(let value):
                print("성공, \(value)")
                
//                self.filterData = self.data.filter({ $0.title.lowercased().contains(searchText) || $0.info.contains(searchText) })

            case .failure(let error):
                print("Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
            }
        }
    }
}

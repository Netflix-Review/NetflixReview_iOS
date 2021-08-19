//
//  EditNameController.swift
//  NetflixReview
//
//  Created by 강호성 on 2021/08/19.
//

import UIKit
import SnapKit

class EditNameController: UITableViewController {
    
    // MARK: - Properties
    
    private let cellId = "EditNameCell"
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        navigationItem.title = "이름 변경"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(goBack))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "수정", style: .done, target: self, action: #selector(editDone))
        
        tableView.register(EditNameCell.self, forCellReuseIdentifier: cellId)
        tableView.tableFooterView = UIView()
    }
    
    // MARK: - Action
    
    @objc func goBack() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func editDone() {
        print("Edit Done")
    }
}

// MARK: - UITableViewDataSource

extension EditNameController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EditNameOption.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! EditNameCell
        
        guard let option = EditNameOption(rawValue: indexPath.row) else { return cell }
        cell.viewModel = EditNameViewModel(option: option)
        return cell
    }
}

//
//  CategoriesVC.swift
//  SebbiaTestTask
//
//  Created by Raul Shafigin on 02.04.2025.
//

import UIKit
import SnapKit

class CategoriesVC: BaseVC {
    let cellId: String = "categoryCell"
  
    var viewModel: CategoriesViewModelProtocol = CategoriesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Categories"
        commonInit()
        configureTableView()
        bindViewModel()
    }
    
    override func configureTableView() {
        tableView.register(CategoryCell.self, forCellReuseIdentifier: cellId)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func bindViewModel() {
        viewModel.categories.bind { [weak self] categories in
            guard let self = self,
                  let _ = categories else { return }
            tableView.reloadData()
        }
    }
}

extension CategoriesVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.categories.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? CategoryCell,
              let categories = viewModel.categories.value else { return UITableViewCell() }
        cell.titleLabel.text = categories[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let list = viewModel.categories.value else { return }
        let newsItem = list[indexPath.row]
        openNewsScreenWith(id: newsItem.id)
        
    }
    
    private func openNewsScreenWith(id: Int) {
        let vc = NewsScreen(id: id)
        navigationController?.pushViewController(vc, animated: true)
    }
}


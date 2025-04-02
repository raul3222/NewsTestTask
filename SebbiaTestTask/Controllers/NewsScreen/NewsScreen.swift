//
//  NewsScreen.swift
//  SebbiaTestTask
//
//  Created by Raul Shafigin on 02.04.2025.
//

import UIKit

class NewsScreen: BaseVC {
    let cellId: String = "newsCell"
    
    var viewModel: NewsViewModelProtocol!
    
    init(id: Int) {
        viewModel = NewsViewModel(id: id)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
        configureTableView()
        bindViewModel()
        navigationController?.navigationBar.tintColor = .white
    }
    
    override func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(NewsCell.self, forCellReuseIdentifier: cellId)
    }
    
    private func bindViewModel() {
        viewModel.news.bind { [weak self] news in
            guard let self = self,
                  let _ = news else { return }
            self.tableView.reloadData()
        }
    }
}

extension NewsScreen: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.news.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? NewsCell,
              let news = viewModel.news.value else { return UITableViewCell() }
        cell.configureCell(with: news[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let news = viewModel.news.value else { return }
        navigateToDetailScreenFor(news: news[indexPath.row])
    }
    
    private func navigateToDetailScreenFor(news: NewsArray) {
        let vc = DetailScreen(id: news.id, title: news.title, subtitle: news.shortDescription)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.size.height
        
        if position > contentHeight - frameHeight * 1.5 && contentHeight > frameHeight {
            viewModel.paginateNews()
        }
    }
}

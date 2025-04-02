//
//  DetailVM.swift
//  SebbiaTestTask
//
//  Created by Raul Shafigin on 02.04.2025.
//

protocol DetailViewModelProtocol {
    var news: Box<News?> { get }
    var newsTitle: String { get }
    var shortDescription: String { get }
}

class DetailViewModel: DetailViewModelProtocol {
    var newsTitle: String
    
    var shortDescription: String
    
    var news: Box<News?> = Box(nil)
    
    init(id: Int, title: String, subtitle: String) {
        self.newsTitle = title
        self.shortDescription = subtitle
        fetchDetailsWith(id: id)
    }
    
    private func fetchDetailsWith(id: Int) {
        APIManager.shared.fetchDetailNewsWith(id: id) { news in
            guard let news = news else { return }
            self.news.value = news.news
        }
    }
}

//
//  NewsVM.swift
//  SebbiaTestTask
//
//  Created by Raul Shafigin on 02.04.2025.
//
import Foundation

protocol NewsViewModelProtocol {
    var news: Box<[NewsArray]?> { get }
    func paginateNews()
}

class NewsViewModel: NewsViewModelProtocol {
    var news: Box<[NewsArray]?> = Box(nil)
    
    private var isLastPage: Bool = false
    private var isLoading: Bool = false
    private var id: Int
    private var currentPage: Int = 0
   
    init(id: Int) {
        self.id = id
        fetchNews()
    }
    
    private func fetchNews() {
        isLoading = true
        APIManager.shared.fetchNewsListWith(id: id, page: currentPage) { news in
            guard let receivedNews = news else { return }
                self.news.value = receivedNews.list
            self.currentPage += 1
            self.isLoading = false
        }
    }
    
    func paginateNews() {
        if isLastPage || isLoading { return }
        isLoading = true
        APIManager.shared.fetchNewsListWith(id: id, page: currentPage) { news in
            guard let receivedNews = news,
            !receivedNews.list.isEmpty else {
                self.isLastPage = true // Because I don't know how many pages I can receive.
                return }
            if var news = self.news.value {
                news.append(contentsOf: receivedNews.list)
                self.news.value = news
            }
            self.currentPage += 1
            self.isLoading = false
        }
    }
}

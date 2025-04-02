//
//  APIManager.swift
//  SebbiaTestTask
//
//  Created by Raul Shafigin on 02.04.2025.
//

import Foundation
import Alamofire

class APIManager {
    static let shared = APIManager()
    private init() {}
    
    let baseURL = APIs.Dev.baseUrl
    
    func fetchCategories(completion: @escaping(Category?) -> ()) {
        let url = baseURL.appendingPathComponent(Endpoint.categories.rawValue)
        
        AF.request(url, method: .get, encoding: JSONEncoding.default)
            .responseDecodable(of: Category.self) { response in
                guard let category = response.value else {
                    completion(nil)
                    return }
                completion(category)
            }
    }
    
    func fetchNewsListWith(id: Int, page: Int, completion: @escaping(NewsList?) -> ()) {
        var components = URLComponents(url: baseURL.appendingPathComponent("\(Endpoint.categories.rawValue)/\(id)/news"), resolvingAgainstBaseURL: false)
        components?.queryItems = [
            URLQueryItem(name: "page", value: "\(page)")
        ]

        guard let url = components?.url else { return }
        
        
        AF.request(url, method: .get, encoding: JSONEncoding.default)
            .responseDecodable(of: NewsList.self) { response in
                guard let news = response.value else {
                    completion(nil)
                    return }
                completion(news)
            }
    }
    
    func fetchDetailNewsWith(id: Int, completion: @escaping(DetailNews?) -> ()) {
        var components = URLComponents(string: baseURL.appendingPathComponent(Endpoint.detailNews.rawValue).absoluteString)
        components?.queryItems = [URLQueryItem(name: "id", value: "\(id)")]
        guard let url = components?.url else { return }
        AF.request(url, method: .get, encoding: JSONEncoding.default)
            .responseDecodable(of: DetailNews.self) { response in
                guard let news = response.value else {
                    completion(nil)
                    return }
                completion(news)
        }
    }
}

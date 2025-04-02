//
//  DetailNews.swift
//  SebbiaTestTask
//
//  Created by Raul Shafigin on 02.04.2025.
//

struct DetailNews: Decodable {
    let news: News
}

struct News: Decodable {
    let id: Int
    let title: String
    let date: String
    let shortDescription: String
    let fullDescription: String
}

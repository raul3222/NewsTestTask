//
//  NewsList.swift
//  SebbiaTestTask
//
//  Created by Raul Shafigin on 02.04.2025.
//

struct NewsList: Decodable {
    var list: [NewsArray]
}

struct NewsArray: Decodable {
    let date: String
    let id: Int
    let shortDescription: String
    let title: String
}

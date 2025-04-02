//
//  Category.swift
//  SebbiaTestTask
//
//  Created by Raul Shafigin on 02.04.2025.
//

struct Category: Decodable {
    let list: [CategoryList]
}

struct CategoryList: Decodable {
    let id: Int
    let name: String
    
}

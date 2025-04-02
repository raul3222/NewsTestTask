//
//  CategoriesVM.swift
//  SebbiaTestTask
//
//  Created by Raul Shafigin on 02.04.2025.
//

protocol CategoriesViewModelProtocol {
    var categories: Box<[CategoryList]?> { get }
}

class CategoriesViewModel: CategoriesViewModelProtocol {
    var categories: Box<[CategoryList]?> = Box(nil)
    
    init() {
        fetchCategories()
    }
    
    private func fetchCategories() {
        APIManager.shared.fetchCategories { category in
            guard let category = category else { return }
            self.categories.value = category.list
        }
    }
}

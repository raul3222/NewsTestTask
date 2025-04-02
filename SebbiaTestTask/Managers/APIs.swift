//
//  APIs.swift
//  SebbiaTestTask
//
//  Created by Raul Shafigin on 02.04.2025.
//
import Foundation

protocol API {
    static var baseUrl: URL { get }
}

public protocol RawRepresentable {
    associatedtype RawValue
    init?(rawValue: Self.RawValue)
}

extension RawRepresentable where RawValue == String, Self: API {
    
    var url: URL { Self.baseUrl}
    
    init?(rawValue: String) { nil }
}

enum APIs {
    enum Dev: RawRepresentable, API {
        static let baseUrl: URL = URL(string: "https://testtask.sebbia.com/")!
    }
}

enum Endpoint: String {
    case categories
    case detailNews
    
    var rawValue: String {
        switch self {
            case .categories: return "v1/news/categories"
            case .detailNews: return "v1/news/details"
        }
    }
}

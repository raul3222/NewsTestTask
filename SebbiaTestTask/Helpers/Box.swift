//
//  Box.swift
//  SebbiaTestTask
//
//  Created by Raul Shafigin on 02.04.2025.
//

class Box<T> {
    typealias Listener = (T) -> Void
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    var listener: Listener?
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(listener: @escaping Listener) {
        listener(value)
        self.listener = listener
    }
}

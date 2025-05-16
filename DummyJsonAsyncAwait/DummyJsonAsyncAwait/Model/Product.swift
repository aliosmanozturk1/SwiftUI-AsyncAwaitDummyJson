//
//  Product.swift
//  DummyJsonAsyncAwait
//
//  Created by Ali Osman Öztürk on 16.05.2025.
//

struct Product: Identifiable, Codable {
    let id: Int
    let title : String
    let description : String
    let price : Double
}

struct ProductResponse: Codable {
    let products : [Product]
}

//
//  Product.swift
//  ShopMobile
//

import Foundation

struct Root: Codable {
    let numberOfProducts: Int
    let products: [Product]
}

struct Product: Codable {
    let id: Int
    let name: String
    let brand: String
    let shortDescription: String
//    let image: ProductImage
}

//struct ProductImage: Codable {
//    let caption: String
//    let sizes: [ImageUrl]
//}
//
//struct ImageUrl: Codable {
//    var url: URL? {
//        return URL(string: self.url[])
//    }
//}

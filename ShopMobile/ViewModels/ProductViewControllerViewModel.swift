//
//  ProductViewControllerViewModel.swift
//  ShopMobile
//

import Foundation

class ProductViewControllerViewModel {
        
    //MARK: - Variables
    let product: Product
    
    //MARK: - Initializer
    init(_ product: Product) {
        self.product = product
    }
        
    //MARK: - Computed Properties
    var brandLabel: String {
        return "Brand: \(self.product.brand)"
    }
    
    var descriptionLabel: String {
        return "Description: \(self.product.shortDescription)"
    }
}

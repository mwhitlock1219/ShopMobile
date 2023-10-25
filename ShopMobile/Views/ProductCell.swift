//
//  ProductCell.swift
//  ShopMobile
//

import Foundation
import SDWebImage

class ProductCell: UITableViewCell {
    
    static let identifier = "ProductCell"
    
    //MARK: - Variables
    private(set) var product: Product!
    
    //MARK: - UI Components
    private let productImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(systemName: "questionmark")
        iv.tintColor = .black
        return iv
    } ()
    
    private let productName: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "Error"
        return label
    } ()
    
    //MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    public func configure(with product: Product){
        self.product = product
        
        self.productName.text = product.name
//        let imageData = try? Data(contentsOf: self.product.image.sizes[0])
//        self.productImage.sd_setImage(with: product.imageURL)
    }
    
    //MARK: - UI Setup
    private func setupUI() {
        self.addSubview(productImage)
        self.addSubview(productName)
        
        self.backgroundColor = .systemGray6

        productImage.translatesAutoresizingMaskIntoConstraints = false
        productName.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            productImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            productImage.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            productImage.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.75),
            productImage.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.75),
            
            productName.leadingAnchor.constraint(equalTo: productImage.trailingAnchor, constant: 16),
            productName.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}

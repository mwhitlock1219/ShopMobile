//
//  ProductViewController.swift
//  ShopMobile
//

import UIKit

class ProductViewController: UIViewController {
    
    //MARK: - Variables
     let viewModel: ProductViewControllerViewModel
    
    //MARK: - UI Components
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        return sv
    }()
    
    private let contentView: UIView = {
        let cv = UIView()
        return cv
    }()
    
    private var productImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(systemName: "questionmark")
        iv.tintColor = .label
        return iv
    }()
    
    private let brandLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.text = "Error"
        return label
    } ()
        
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "Error"
        return label
    } ()

    private lazy var vStack: UIStackView = {
        let vStack = UIStackView(arrangedSubviews: [brandLabel, descriptionLabel])
        vStack.axis = .vertical
        vStack.spacing = 25
        vStack.distribution = .fill
        vStack.alignment = .center
        return vStack
    }()


    //MARK: - LifeCycle

    init(_ viewModel: ProductViewControllerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        
        self.view.backgroundColor = .systemBackground
        self.navigationItem.title = self.viewModel.product.name
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: nil, action: nil)
        
        self.brandLabel.text = self.viewModel.product.brand
        self.descriptionLabel.text = self.viewModel.product.shortDescription
//        self.productImage = self.viewModel.product.image.sizes[0]
    }
    
    //MARK: - UI Setup
    
    private func setupUI() {
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(contentView)
        self.contentView.addSubview(productImage)
        self.contentView.addSubview(vStack)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        productImage.translatesAutoresizingMaskIntoConstraints = false
        vStack.translatesAutoresizingMaskIntoConstraints = false

        let height = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        height.priority = UILayoutPriority(1)
        height.isActive = true
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            scrollView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            productImage.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            productImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
            productImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            productImage.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            productImage.heightAnchor.constraint(equalToConstant: 200),
            
            vStack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            vStack.topAnchor.constraint(equalTo: productImage.bottomAnchor, constant: 20),
            vStack.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            vStack.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            vStack.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
    }
    
    
    //MARK: - Selectors


    
}


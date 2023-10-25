//
//  HomeViewController.swift
//  ShopMobile
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Variables
    private var products: [Product] = []

    //MARK: - UI Components
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(ProductCell.self, forCellReuseIdentifier: ProductCell.identifier)
        return table
    } ()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        
        tableView.delegate = self
        tableView.dataSource = self
 
        fetch()
    }

    //MARK: - UI Setup
    private func setupUI() {
        title = "Shop Mobile"
        //style nav
        
        self.view.addSubview(tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.identifier, for: indexPath) as? ProductCell else {
            fatalError("Unable to dequeue CoinCell in ViewController")
        }
        let product = self.products[indexPath.row]
        cell.configure(with: product)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        let product = self.products[indexPath.row]
        let vm = ProductViewControllerViewModel(product)
        let vc = ProductViewController(vm)
        self.navigationController?.pushViewController(vc, animated: true)
    }

    //MARK: - Fetch data
    func fetch() {
        URLSession.shared.request(
            url: Constants.shopURL,
            expecting: Root.self
        ) { [weak self] result in
                switch result {
                case .success(let products):
                    DispatchQueue.main.async {
                               
                        let products = try! result.get().products
                           print("Input dictionary: \(products)")
                        
                        self?.products = products
                        self?.tableView.reloadData()
                    }
                case .failure(let error):
                    print(error)
                }
            }
    }


}

extension URLSession {
    enum CustomError: Error {
        case invalidURL
        case invalidData
    }

    func request<T: Codable>(url: URL?, expecting: T.Type, completion: @escaping (Result<T, Error>) -> Void ) {
        guard let url = url else {
            completion(.failure(CustomError.invalidURL))
            return
        }
        
        let task = dataTask(with: url) { data, _, error in
            guard let data = data else { 
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(CustomError.invalidData))
                }
                return
            }
            do{
                let result = try JSONDecoder().decode(expecting, from: data)
                    completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}

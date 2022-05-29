//
//  ProductViewController.swift
//  MeliChallenge
//
//  Created by Mayerly Rios on 26/05/22.
//

import UIKit

class ProductViewController: MeLiCustomNavigationViewController {

    @IBOutlet weak var productTableView: UITableView!
    
    var productListViewModel = ProductListViewModel()
    var productCategory: Category?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        productListViewModel.getProductByCategory(id: productCategory?.id)
    }
    
    private func setupInitialView() {
        customNavBar.delegate = self
        customNavBar.setupTitleNavBar(title: productCategory?.name)
        observerStatusProduct()
        setupTableView()
    }
    
    private func setupTableView() {
        productTableView.register(UINib(nibName: Constants.PRODUCT_VIEW_CELL, bundle: nil), forCellReuseIdentifier: ProductViewCell.identifier)
        productTableView.delegate = self
        productTableView.dataSource = self
        productTableView.rowHeight = UITableView.automaticDimension
    }
    
    private func observerStatusProduct() {
        productListViewModel.onDidChangeProductStatus = { [weak self] status in
            switch status {
            case .idle, .loading:
                print("aaa")
            case .success:
                DispatchQueue.main.async {
                    self?.productTableView.reloadData()
                }
                return
            case .failure:
                print("aaa")
            }
        }
    }
}
// MARK: - UITableViewDataSource
extension ProductViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productListViewModel.productResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ProductViewCell.identifier) as? ProductViewCell else { return UITableViewCell() }
        cell.product = productListViewModel.productResult[indexPath.row]
        return cell
    }
}
// MARK: - UITableViewDelegate
extension ProductViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        productListViewModel.didSelectProduct(navigationController: navigationController, cellForItemAt: indexPath)
    }
}

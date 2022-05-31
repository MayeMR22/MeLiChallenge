//
//  ProductViewController.swift
//  MeliChallenge
//
//  Created by Mayerly Rios on 26/05/22.
//

import UIKit
import SkeletonView

class ProductViewController: MeLiCustomNavigationViewController {

    @IBOutlet weak var productTableView: UITableView!
    
    var productListViewModel = ProductListViewModel()
    var productCategory: CategoryModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
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
        productTableView.estimatedRowHeight = 120
    }
    
    private func observerStatusProduct() {
        productListViewModel.onDidChangeProductStatus = { [weak self] status in
            guard let self = self else { return }
            switch status {
            case .idle, .loading:
                self.view.showAnimatedGradientSkeleton()
            case .success:
                DispatchQueue.main.async {
                    self.productTableView.reloadData()
                    self.view.hideSkeleton()
                }
                return
            case .failure(let error):
                DispatchQueue.main.async {
                    AlertInfo.show(controller: self, message: error)
                }
            }
        }
    }
}
// MARK: - UITableViewDataSource
extension ProductViewController: SkeletonTableViewDataSource {
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return ProductViewCell.identifier
    }
    
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
        let storyboard = UIStoryboard(name: "ProductDetail", bundle: nil)
        if let productDetailVC = storyboard.instantiateViewController(withIdentifier: "ProductDetail") as? ProductDetailViewController {
            productDetailVC.product = productListViewModel.productResult[indexPath.row]
            navigationController?.pushViewController(productDetailVC, animated: true)
        }
    }
}

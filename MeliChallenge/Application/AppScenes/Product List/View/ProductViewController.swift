//
//  ProductViewController.swift
//  MeliChallenge
//
//  Created by Mayerly Rios on 26/05/22.
//

import UIKit
import SkeletonView
import Network

class ProductViewController: MeLiCustomNavigationViewController {

    @IBOutlet weak var productTableView: UITableView!
    
    var productListViewModel = ProductListViewModel()
    var productCategory: CategoryModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard NetworkMonitor.shared.isNetworkAvailable() else { return }
        productListViewModel.getProductByCategory(id: productCategory?.id)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NetworkMonitor.shared.stop()
    }
    
    private func setupInitialView() {
        customNavBar.delegate = self
        customNavBar.setupTitleNavBar(title: productCategory?.name)
        observerStatusProduct()
        setupTableView()
        setUpEventDelegateNetworkMonitor()
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
    
    func setUpEventDelegateNetworkMonitor() {
        NetworkMonitor.shared.delegate = self
        NetworkMonitor.shared.start()
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
// MARK: - NetworkMonitor Delegate
extension ProductViewController: NetworkMonitorDelegate {
    func networkMonitor(didChangeStatus status: NWPath.Status) {
        if status != .satisfied {
            AlertInfo.show(controller: self, message: Constants.MESSAGE_NETWORK)
        }
    }
}

//
//  ProductDetailViewController.swift
//  MeliChallenge
//
//  Created by Mayerly Rios on 26/05/22.
//

import UIKit
import SDWebImage
import SkeletonView
import Network

class ProductDetailViewController: MeLiCustomNavigationViewController {

    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productSoldQuantityLabel: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    
    var product: Results?
    var productDetailViewModel = ProductDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialView()
        setUpEventDelegateNetworkMonitor()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard NetworkMonitor.shared.isNetworkAvailable() else { return }
        productDetailViewModel.productDescription(itemId: product?.id)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NetworkMonitor.shared.stop()
    }
    
    private func setupInitialView() {
        observerDescriptionStatus()
        customNavBar.delegate = self
        setupView()
    }
    
    private func setupView() {
        if let product = product {
            productImage.sd_setImage(with: URL(string: product.thumbnail?.changeHttpUrl()  ?? ""), placeholderImage: nil)
            productNameLabel.text = product.title
            productPrice.text = String(product.price.description.formatPrice())
            productSoldQuantityLabel.text = "\(product.soldQuantity ?? 0) Vendidos"
        }
    }
    
    private func observerDescriptionStatus() {
        productDetailViewModel.onDidChangeDescriptionStatus = { [weak self] status in
            guard let self = self else { return }
            switch status {
            case .idle, .loading:
                self.view.showAnimatedGradientSkeleton()
            case .success:
                DispatchQueue.main.async {
                    self.productDescription.text = self.productDetailViewModel.productDescription
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
    
    private func setUpEventDelegateNetworkMonitor() {
        NetworkMonitor.shared.delegate = self
        NetworkMonitor.shared.start()
    }
}
// MARK: - NetworkMonitor Delegate
extension ProductDetailViewController: NetworkMonitorDelegate {
    func networkMonitor(didChangeStatus status: NWPath.Status) {
        if status != .satisfied {
            AlertInfo.show(controller: self, message: Constants.MESSAGE_NETWORK)
        }
    }
}

//
//  ProductDetailViewController.swift
//  MeliChallenge
//
//  Created by Mayerly Rios on 26/05/22.
//

import UIKit
import SDWebImage

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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        productDetailViewModel.productDescription(itemId: "MLA811770217")
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
            switch status {
            case .idle, .loading:
                print("aaa")
            case .success:
                DispatchQueue.main.async {
                    self?.productDescription.text = self?.productDetailViewModel.productDescription
                }
                return
            case .failure:
                print("aaa")
            }
        }
    }
}

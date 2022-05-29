//
//  ProductListViewModel.swift
//  MeliChallenge
//
//  Created by Mayerly Rios on 26/05/22.
//

import Foundation
import UIKit

class ProductListViewModel {
    
    let producByCategoryUseCase: ProducByCategoryUseCase
    
    var product: Product?
    var productResult : [Results] = []
    
    
    var onDidChangeProductStatus: ((ProcessStatus) -> Void)?
    var productStatus: ProcessStatus = .idle {
        didSet { onDidChangeProductStatus?(productStatus) }
    }
    
    init(producByCategoryUseCase: ProducByCategoryUseCase = ProducByCategoryUseCaseImpl()) {
        self.producByCategoryUseCase = producByCategoryUseCase
    }
    
    func getProductByCategory(id : String?) {
        productStatus = .loading
        guard let categoryId = id else {
            productStatus = .failure
            return
        }
        producByCategoryUseCase.execute(parameter: .init(categoryId: categoryId)) { [weak self] (product, error)  in
            if error != nil {
                self?.productStatus = .failure
            }
            if let product = product {
                self?.productResult = product.results ?? []
                self?.product = product
                self?.productStatus = .success
            }
        }
    }
    
    func didSelectProduct(navigationController: UINavigationController?, cellForItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "ProductDetail", bundle: nil)
        if let productDetailVC = storyboard.instantiateViewController(withIdentifier: "ProductDetail") as? ProductDetailViewController {
            productDetailVC.product = productResult[indexPath.row]
            navigationController?.pushViewController(productDetailVC, animated: true)
        }
    }
}

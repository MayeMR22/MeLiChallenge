//
//  ProductListViewModel.swift
//  MeliChallenge
//
//  Created by Mayerly Rios on 26/05/22.
//

import Foundation

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
        guard let categoryId = id else {
            productStatus = .failure("APINetworkError.noFound.localizedDescription")
            return
        }
        setupShimmerProduct()
        productStatus = .loading
        producByCategoryUseCase.execute(parameter: .init(categoryId: categoryId)) { [weak self] (product, error)  in
            if let error = error {
                self?.productStatus = .failure(error.localizedDescription)
            }
            if let product = product {
                self?.productResult = product.results ?? []
                self?.product = product
                self?.productStatus = .success
            }
        }
    }
    
    func setupShimmerProduct() {
        self.productResult = Array(repeating: Results.getModelResultBasic(), count: 6)
    }
}

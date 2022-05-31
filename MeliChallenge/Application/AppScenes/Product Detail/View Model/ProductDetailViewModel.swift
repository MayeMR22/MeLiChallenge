//
//  ProductDetailViewModel.swift
//  MeliChallenge
//
//  Created by Mayerly Rios on 26/05/22.
//

import Foundation

class ProductDetailViewModel {
    
    let productDescriptionUseCase: ProductDescriptionUseCase
    var productDescription: String?
    
    var onDidChangeDescriptionStatus: ((ProcessStatus) -> Void)?
    var descriptionStatus: ProcessStatus = .idle {
        didSet { onDidChangeDescriptionStatus?(descriptionStatus) }
    }
    
    init(productDescriptionUseCase: ProductDescriptionUseCase = ProductDescriptionUseCaseImpl()) {
        self.productDescriptionUseCase = productDescriptionUseCase
    }
    
    func productDescription(itemId: String?) {
        guard let itemId = itemId else {
            descriptionStatus = .failure(APINetworkError.noFound.localizedDescription)
            return
        }
        self.descriptionStatus = .loading
        productDescriptionUseCase.execute(id: itemId) { [weak self] (description, error)  in
            if let error = error {
                self?.descriptionStatus = .failure(error.localizedDescription)
            }
            if let description = description {
                self?.productDescription = description.plainText
                self?.descriptionStatus = .success
            }
        }
    }
}

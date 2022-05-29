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
            descriptionStatus = .failure
            return
        }
        self.descriptionStatus = .loading
        productDescriptionUseCase.execute(id: itemId) { [weak self] (description, error)  in
            if error != nil {
                self?.descriptionStatus = .failure
            }
            if let description = description {
                self?.productDescription = description.plainText
                self?.descriptionStatus = .success
            }
        }
        
    }
}

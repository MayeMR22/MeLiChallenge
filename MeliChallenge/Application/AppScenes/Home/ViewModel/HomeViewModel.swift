//
//  HomeViewModel.swift
//  MeliChallenge
//
//  Created by Mayerly Rios on 24/05/22.
//

import Foundation

class HomeViewModel {
    var categoryList: [CategoryModel] = []
    let getCategoryUseCase: GetCategoryUseCase
    
    var onDidChangeCategoryStatus: ((ProcessStatus) -> Void)?
    var categoryStatus: ProcessStatus = .idle {
        didSet { onDidChangeCategoryStatus?(categoryStatus) }
    }
    
    init(getCategoryUseCase: GetCategoryUseCase = GetCategoryUseCaseImpl()) {
        self.getCategoryUseCase = getCategoryUseCase
    }
    
    func getCategory() {
        setupCategoryShimmer()
        categoryStatus = .loading
        getCategoryUseCase.execute { [weak self] (category, error) in
            if let error = error {
                self?.categoryList = []
                self?.categoryStatus = .failure(error.localizedDescription)
            }
            if let category = category {
                self?.categoryList = category
                self?.categoryStatus = .success
            }
        }
    }
    
    func setupCategoryShimmer() {
        categoryList = Array(repeating: CategoryModel.getModelCategoryBasic(), count: 6)
    }
}

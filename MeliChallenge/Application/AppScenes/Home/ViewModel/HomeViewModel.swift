//
//  HomeViewModel.swift
//  MeliChallenge
//
//  Created by Mayerly Rios on 24/05/22.
//

import Foundation
import UIKit

class HomeViewModel {
    var categoryList: [Category] = []
    let getCategoryUseCase: GetCategoryUseCase
    
    var onDidChangeCategoryStatus: ((ProcessStatus) -> Void)?
    var categoryStatus: ProcessStatus = .idle {
        didSet { onDidChangeCategoryStatus?(categoryStatus) }
    }
    init(getCategoryUseCase: GetCategoryUseCase = GetCategoryUseCaseImpl()) {
        self.getCategoryUseCase = getCategoryUseCase
    }
    
    
    func getCategory() {
        categoryStatus = .loading
        getCategoryUseCase.execute { [weak self] (category, error) in
            if error != nil {
                self?.categoryStatus = .failure
            }
            if let category = category {
                self?.categoryList = category
                self?.categoryStatus = .success
            }
        }
    }
    
    func didSelectCategory(navigationController: UINavigationController?, cellForItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "ProductList", bundle: nil)
        if let productListVC = storyboard.instantiateViewController(withIdentifier: "ProductList") as? ProductViewController {
            productListVC.productCategory = categoryList[indexPath.row]
            navigationController?.pushViewController(productListVC, animated: true)
        }
    }
}

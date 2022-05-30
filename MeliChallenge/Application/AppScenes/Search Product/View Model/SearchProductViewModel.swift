//
//  SearchProductViewModel.swift
//  MeliChallenge
//
//  Created by Mayerly Rios on 27/05/22.
//

import Foundation

class SearchProductViewModel {
    
    let searchProductUseCase: SearchProductUseCase
    
    var searchResult: SearchResult?
    var searchProduct: [Results] = []
    var onDidChangeSearchStatus: ((ProcessStatus) -> Void)?
    var offset: Int = 0
    var searchStatus: ProcessStatus = .idle {
        didSet { onDidChangeSearchStatus?(searchStatus) }
    }
    
    init(searchProductUseCase: SearchProductUseCase = SearchProductUseCaseImpl()) {
        self.searchProductUseCase = searchProductUseCase
    }
    
    func searchProduct(search: String?, fetchMore: Bool) {
        guard let search = search else {
            searchStatus = .failure
            return
        }
        setupSearchShimmer()
        searchStatus = .loading
        searchProductUseCase.execute(parameter: .init(searchText: search, offset: offset)) { [weak self] (search, error) in
            if error != nil {
                self?.searchStatus = .failure
            }
            if let search = search {
                self?.searchResult = search
                self?.searchProduct = search.results ?? []
                self?.setupPagination(pagination: search.paging, fetchMore: fetchMore)
                self?.searchStatus = .success
            }
        }
    }
    
    func setupPagination(pagination: Paging?, fetchMore: Bool) {
        if let pagination = pagination {
            let totalPage = pagination.primaryResults
            if offset < totalPage {
                self.offset += 20
                print(offset)
            }
        } else {
            print(offset)
        }
    }
    
    private func setupSearchShimmer() {
        self.searchProduct.append(Results.getModelResultBasic(shimmer: true))
    }
}
// MARK: - Protocols
protocol SearchProductDelegate: AnyObject {
    func searchProduct(productSelect product: Results)
}

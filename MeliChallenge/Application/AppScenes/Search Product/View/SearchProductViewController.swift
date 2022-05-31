//
//  SearchProductViewController.swift
//  MeliChallenge
//
//  Created by Mayerly Rios on 27/05/22.
//

import UIKit
import SkeletonView

class SearchProductViewController: UIViewController {
    
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var emptyState: UIView!
    
    let searchProductViewModel = SearchProductViewModel()
    let searchController = UISearchController(searchResultsController: nil)
    var isPaginating = false
    var currentOffset: CGFloat = 0
    weak var delegate: SearchProductDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialView()
    }
    
    private func setupInitialView() {
        emptyState.isHidden = true
        observerSearchStatus()
        setupTableView()
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.sizeToFit()
        searchBar.delegate = self
    }
    
    private func observerSearchStatus() {
        searchProductViewModel.onDidChangeSearchStatus = { [weak self] status in
            guard let self = self else { return }
            switch status {
            case .idle, .loading:
                break
            case .success:
                DispatchQueue.main.async {
                    self.statusEmptyStateAndSearchTable()
                }
                return
            case .failure(let error):
                DispatchQueue.main.async {
                    AlertInfo.show(controller: self, message: error)
                }
                return
            }
        }
    }
    
    private func setupTableView() {
        searchTableView.register(UINib(nibName: Constants.PRODUCT_VIEW_CELL, bundle: nil), forCellReuseIdentifier: ProductViewCell.identifier)
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.rowHeight = UITableView.automaticDimension
        searchTableView.estimatedRowHeight = 120
    }
    
    private func statusEmptyStateAndSearchTable() {
        let productCount = self.searchProductViewModel.searchProduct.count
        self.emptyState.isHidden = productCount > 0
        self.searchTableView.isHidden = productCount == 0
        self.searchTableView.reloadData()
        self.view.hideSkeleton()
        self.isPaginating = true
        self.searchTableView.isUserInteractionEnabled = true
    }
}
// MARK: - Action
extension SearchProductViewController {
    @IBAction func closePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
// MARK: - SearchBar Delegate
extension SearchProductViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        isPaginating = false
        self.view.showAnimatedGradientSkeleton()
        searchProductViewModel.searchProduct(search: searchBar.text, fetchMore: false)
    }
}
// MARK: - UITableViewDataSource
extension SearchProductViewController: SkeletonTableViewDataSource {
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return ProductViewCell.identifier
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchProductViewModel.searchProduct.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ProductViewCell.identifier) as? ProductViewCell else { return UITableViewCell() }
        cell.product = searchProductViewModel.searchProduct[indexPath.row]
        return cell
    }
}
// MARK: - UITableViewDelegate
extension SearchProductViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productSelect = searchProductViewModel.searchProduct[indexPath.row]
        delegate?.searchProduct(productSelect: productSelect)
        dismiss(animated: true, completion: nil)
    }
}
// MARK: - Scroll ViewDelegate
extension SearchProductViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard isPaginating else { return }
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if (distanceFromBottom < height) && contentYoffset > currentOffset {
            currentOffset = contentYoffset
            isPaginating = true
            searchTableView.isUserInteractionEnabled = false
            let lastIndex = searchProductViewModel.searchProduct.count - 1
            for index in (lastIndex - 2)...lastIndex {
                if let cell = searchTableView.cellForRow(at: IndexPath(row: index, section: 0)) {
                    cell.showAnimatedGradientSkeleton()
                }
            }
            searchProductViewModel.searchProduct(search: searchBar.text, fetchMore: true)
        }
    }
}
// MARK: - Show Search View
extension SearchProductViewController {
    static func show(controller: UIViewController, delegate: SearchProductDelegate) {
        let storyboard: UIStoryboard = UIStoryboard(name: "SearchProduct", bundle: nil)
        guard let searchEngineVC = storyboard.instantiateViewController(withIdentifier: "SearchProduct") as? SearchProductViewController else { return }
        searchEngineVC.modalPresentationStyle = .overFullScreen
        searchEngineVC.modalTransitionStyle = .crossDissolve
        searchEngineVC.delegate = delegate
        controller.present(searchEngineVC, animated: true, completion: nil)
    }
}


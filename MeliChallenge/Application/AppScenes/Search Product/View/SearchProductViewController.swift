//
//  SearchProductViewController.swift
//  MeliChallenge
//
//  Created by Mayerly Rios on 27/05/22.
//

import UIKit

class SearchProductViewController: UIViewController {
    
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let searchProductViewModel = SearchProductViewModel()
    let searchController = UISearchController(searchResultsController: nil)
    
    var currentOffset: CGFloat = 0
    weak var delegate: SearchProductDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialView()
    }
    
    private func setupInitialView() {
        observerSearchStatus()
        setupTableView()
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.sizeToFit()
        searchBar.delegate = self
    }
    
    private func observerSearchStatus() {
        searchProductViewModel.onDidChangeSearchStatus = { [weak self] status in
            switch status {
            case .idle, .loading:
                print("aaa")
            case .success:
                DispatchQueue.main.async {
                    self?.searchTableView.reloadData()
                }
                return
            case .failure:
                print("aaa")
            }
        }
    }
    
    private func setupTableView() {
        searchTableView.register(UINib(nibName: Constants.PRODUCT_VIEW_CELL, bundle: nil), forCellReuseIdentifier: ProductViewCell.identifier)
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.rowHeight = UITableView.automaticDimension
    }
    
    @IBAction func closePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
// MARK: - SearchBar Delegate
extension SearchProductViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchProductViewModel.searchProduct(search: searchBar.text, fetchMore: false)
    }
}
// MARK: - UITableViewDataSource
extension SearchProductViewController: UITableViewDataSource {
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
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if (distanceFromBottom < height) && contentYoffset > currentOffset {
            currentOffset = contentYoffset
            //searchProductViewModel.searchProduct(search: searchBar.text, fetchMore: true)
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


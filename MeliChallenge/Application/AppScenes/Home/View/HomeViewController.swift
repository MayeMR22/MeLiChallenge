//
//  HomeViewController.swift
//  MeliChallenge
//
//  Created by Mayerly Rios on 25/05/22.
//

import UIKit
import SkeletonView
import Network

class HomeViewController: MeLiCustomNavigationViewController {
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    var viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customNavBar.delegate = self
        setupCollectionViews()
        observerCategoryStatus()
        setUpEventDelegateNetworkMonitor()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard NetworkMonitor.shared.isNetworkAvailable() else { return }
        viewModel.getCategory()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NetworkMonitor.shared.stop()
    }
    
    private func setupCollectionViews() {
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        categoryCollectionView.register(UINib(nibName: Constants.CATEGORY_VIEW_CELL, bundle: nil), forCellWithReuseIdentifier: CategoryViewCell.identifier)
    }
    
    func observerCategoryStatus() {
        self.viewModel.onDidChangeCategoryStatus = { [weak self] status in
            guard let self = self else { return }
            switch status {
            case .idle, .loading:
                self.view.showAnimatedGradientSkeleton(transition: .none)
            case .success:
                DispatchQueue.main.async {
                    self.view.hideSkeleton()
                    self.categoryCollectionView.reloadData()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    AlertInfo.show(controller: self, message: error)
                }
            }
        }
    }
    
    func setUpEventDelegateNetworkMonitor() {
        NetworkMonitor.shared.delegate = self
        NetworkMonitor.shared.start()
    }
}
// MARK: - UICollectionViewDelegate & CollectionViewDataSource
extension HomeViewController: SkeletonCollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return Constants.CATEGORY_VIEW_CELL
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.categoryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryViewCell.identifier, for: indexPath) as? CategoryViewCell else { return UICollectionViewCell() }
        cell.category = viewModel.categoryList[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "ProductList", bundle: nil)
        if let productListVC = storyboard.instantiateViewController(withIdentifier: "ProductList") as? ProductViewController {
            productListVC.productCategory = viewModel.categoryList[indexPath.row]
            navigationController?.pushViewController(productListVC, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let aaa = viewModel.categoryList.count
         let settings: (items: Int, columns: CGFloat, horizontalSpacing: CGFloat, verticalSpacing: CGFloat) = (aaa, 4, 24, 16)
        let cellWidth = collectionView.bounds.width/settings.columns - ((settings.columns - 1)*settings.horizontalSpacing)/settings.columns
        return CGSize(width: cellWidth, height: 120)
    }
}
// MARK: - NetworkMonitor Delegate
extension HomeViewController: NetworkMonitorDelegate {
    func networkMonitor(didChangeStatus status: NWPath.Status) {
        if status != .satisfied {
            AlertInfo.show(controller: self, message: Constants.MESSAGE_NETWORK)
        }
    }
}

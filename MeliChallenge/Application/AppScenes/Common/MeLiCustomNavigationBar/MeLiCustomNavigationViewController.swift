//
//  MeLiCustomNavigationViewController.swift
//  MeliChallenge
//
//  Created by Mayerly Rios on 27/05/22.
//

import UIKit

class MeLiCustomNavigationViewController: UIViewController {
    
    @IBOutlet var customNavBar: MeLiCustomNavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
// MARK: - MeLi CustomNavigationBar Delegate
extension MeLiCustomNavigationViewController: MeLiCustomNavigationBarDelegate {
    func customNavigationBar(requestActionForButton button: CustomNavigationBarButton) {
        switch button {
        case .search:
            SearchProductViewController.show(controller: self, delegate: self)
        case .back:
            if let navigation = self.navigationController {
                navigation.popViewController(animated: true)
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}
// MARK: - SearchProduct Delegate
extension MeLiCustomNavigationViewController: SearchProductDelegate {
    func searchProduct(productSelect product: Results) {
        let storyboard = UIStoryboard(name: "ProductDetail", bundle: nil)
        if let productDetailVC = storyboard.instantiateViewController(withIdentifier: "ProductDetail") as? ProductDetailViewController {
            productDetailVC.product = product
            navigationController?.pushViewController(productDetailVC, animated: true)
        }
    }
}

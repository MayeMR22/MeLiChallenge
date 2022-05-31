//
//  CategoryViewCell.swift
//  MeliChallenge
//
//  Created by Mayerly Rios on 25/05/22.
//

import UIKit

class CategoryViewCell: UICollectionViewCell {

    @IBOutlet weak var categoryLabel: UILabel!
    
    static let identifier = Constants.CATEGORY_VIEW_CELL
    override var reuseIdentifier: String? { return CategoryViewCell.identifier }
    
    var category: CategoryModel? {
        didSet {
            setupView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func setupView() {
        if let category = category {
            categoryLabel.text = category.name
        }
    }
}

//
//  ProductViewCell.swift
//  MeliChallenge
//
//  Created by Mayerly Rios on 26/05/22.
//

import UIKit
import SDWebImage

class ProductViewCell: UITableViewCell {

    @IBOutlet weak var mercadoPagoView: UIView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productPriceLabel: UILabel!
    
    static let identifier = Constants.CATEGORY_VIEW_CELL
    override var reuseIdentifier: String? { return CategoryViewCell.identifier }
    
    var product: Results? {
        didSet {
            setupView()
        }
    }
    
    private func setupView() {
        if let product = product {
            productImage.sd_setImage(with: URL(string: product.thumbnail?.changeHttpUrl()  ?? ""), placeholderImage: nil)
            productNameLabel.text = product.title
            productPriceLabel.text = String(product.price.description.formatPrice())
            mercadoPagoView.isHidden = !(product.acceptsMercadopago ?? false)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

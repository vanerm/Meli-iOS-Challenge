//
//  ProductTableViewCell.swift
//  Meli
//
//  Created by Vanesa Mizrahi on 17/03/2021.
//

import UIKit
import Kingfisher

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productPriceLabel: UILabel!
    
    
    func setupWith(_ product: Product){
        if let theTitle = product.title{
            productTitleLabel.text = theTitle
        } else {
            productTitleLabel.text = ""
        }
        
        if let price = product.price, let currency = product.currency{
            productPriceLabel.text = "\(currency) \(price)"
        } else{
            productPriceLabel.text = ""
        }
        
        if let imageUrl = product.thumbnail {
            let url = URL(string: imageUrl)
            productImageView.kf.setImage(with: url)
        } else {
            productImageView.image = nil
            productImageView.backgroundColor = .yellow
            productImageView.image = UIImage(named: "logoMeli")
        }
        
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

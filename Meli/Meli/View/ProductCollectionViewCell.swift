//
//  ProductCollectionViewCell.swift
//  Meli
//
//  Created by Vanesa Mizrahi on 17/03/2021.
//

import UIKit
import Kingfisher

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productContenView: UIView!
    
    
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
        }
        

// Borde redondeado del contentView
        productContenView.clipsToBounds = true
        productContenView.layer.cornerRadius = 10
        
// Sombra de la celda
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.layer.shadowRadius = 10
        self.layer.shadowOpacity = 0.3
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
        
    }
    
}

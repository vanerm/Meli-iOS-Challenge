//
//  SearchedProductsCollectionViewCell.swift
//  Meli
//
//  Created by Vanesa Mizrahi on 24/03/2021.
//

import UIKit
import Kingfisher


class SearchedProductsCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var productContenView: UIView!

    
    func setupWith(_ product: Product){
        
        if let theTitle = product.title{
            titleLabel.text = theTitle
        } else {
            titleLabel.text = ""
        }
        
        if let price = product.price, let currency = product.currency{
            priceLabel.text = "\(currency) \(price)"
        } else{
            priceLabel.text = ""
        }
        
        if let imageUrl = product.thumbnail {
            let url = URL(string: imageUrl)
            productImageView.kf.setImage(with: url)
            productImageView.clipsToBounds = true
        } else {
            productImageView.image = nil
            productImageView.backgroundColor = .yellow
            productImageView.image = UIImage(named: "logoMeli")
        }
    

        // Shadow
        productContenView.layer.shadowColor = UIColor.gray.cgColor
        productContenView.layer.shadowOffset = CGSize(width: 0, height: 0)
        productContenView.layer.shadowRadius = 6
        productContenView.layer.cornerRadius = 6
        self.layer.cornerRadius = 6
        productContenView.layer.shadowOpacity = 0.05
        productContenView.layer.masksToBounds = false
        productContenView.layer.shadowPath = UIBezierPath(roundedRect: productContenView.bounds, cornerRadius: productContenView.layer.cornerRadius).cgPath
        productContenView.layer.shouldRasterize = true
        productContenView.layer.rasterizationScale = UIScreen.main.scale
        
        productContenView.layer.shadowPath = UIBezierPath(rect: productContenView.bounds).cgPath
        productContenView.layer.shouldRasterize = true
        productContenView.layer.rasterizationScale = UIScreen.main.scale
        
        
    }
    
}

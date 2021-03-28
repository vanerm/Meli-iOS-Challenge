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

    
    override func awakeFromNib() {
      super.awakeFromNib()
      productContenView.layer.cornerRadius = 6
      productContenView.layer.masksToBounds = true
    }
    
    
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
        }
    

        // Sombra de la celda
//        self.layer.shadowColor = UIColor.gray.cgColor
//        self.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
//        self.layer.shadowRadius = 6
//        self.layer.shadowOpacity = 0.2
//        self.layer.masksToBounds = false
//        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
//        self.layer.shouldRasterize = true
//        self.layer.rasterizationScale = UIScreen.main.scale
        
    }
    
}

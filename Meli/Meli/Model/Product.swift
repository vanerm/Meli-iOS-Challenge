//
//  Product.swift
//  Meli
//
//  Created by Vanesa Mizrahi on 14/03/2021.
//

import Foundation

public class Product{
    var id: String
    var title: String?
    var price: Double?
    var currency: String?
    var permalink: String?
    var thumbnail: String?
    
    public init(with dictionary: [String:AnyObject]){
        self.id = dictionary["id"] as? String ?? "no id"
        self.title = dictionary["title"] as? String ?? "no title"
        self.price = dictionary["price"] as? Double ?? 00.00
        self.currency = dictionary["currency_id"] as? String ?? "no currency"
        self.permalink = dictionary["permalink"] as? String ?? "no permalink"
        self.thumbnail = dictionary["thumbnail"] as? String ?? "no thumbnail"
    }
    

}

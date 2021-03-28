//
//  MeliDao.swift
//  Meli
//
//  Created by Vanesa Mizrahi on 14/03/2021.
//

import Foundation
import Alamofire

class MeliDao{
    func getResultFromApiForQuery(_ query: String, offset: Int, completion: @escaping (([Product])-> Void)){
        
        let url = "https://api.mercadolibre.com/sites/MLU/search?q=\(query)&offset=\(offset)"
        
        Alamofire.request(url).responseJSON { (response) in
            
            if let mainDictionary = response.result.value as? [String: AnyObject]{
                if let results = mainDictionary["results"] as? [[String: AnyObject]]{
                    
                    var productsArray: [Product] = []
                    for aDictionary in results{
                        let newProduct = Product(with: aDictionary)
                        productsArray.append(newProduct)
                    }
                    completion(productsArray)
                    
                } else {
                    completion([])
                }
            }
        }
    }
}

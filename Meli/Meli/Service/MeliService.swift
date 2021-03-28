//
//  MeliService.swift
//  Meli
//
//  Created by Vanesa Mizrahi on 14/03/2021.
//

import Foundation

class MeliService{
    func Searchproduct(query: String, offset: Int, completionHandler: @escaping (([Product])-> Void)){
        
        let dao = MeliDao()
        dao.getResultFromApiForQuery(query, offset: offset) { (products) in
            completionHandler(products)
        }
    }
}

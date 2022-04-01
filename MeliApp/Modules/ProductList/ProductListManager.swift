//
//  ProductListManager.swift
//  MeliApp
//
//  Created by Luis Alejandro Barbosa Lee on 30/03/22.
//  Copyright (c) 2022 Luis Alejandro Barbosa Lee. All rights reserved.

import Foundation
import os.log

protocol IProductListManager:IBaseManager {
    func searchForProduct(text: String,
                          offset: Int,
                          handler: @escaping (Result<Products, ErrorResponses>) -> Void)
}

class ProductListManager: IProductListManager {
    
    private let comunicationManager = ComunicationManager()
	
    func searchForProduct(text: String,
                          offset: Int,
                          handler: @escaping (Result<Products, ErrorResponses>) -> Void) {
        comunicationManager.searchForProduct(query: text,
                                             offset: offset,
                                             handler: handler)
    }
    
}

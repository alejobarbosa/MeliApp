//
//  ProductDetailManager.swift
//  MeliApp
//
//  Created by Luis Alejandro Barbosa Lee on 1/04/22.
//  Copyright (c) 2022 Alejandro Barbosa. All rights reserved.

import Foundation

protocol IProductDetailManager: IBaseManager {
    func getProductDetail(productId: String,
                          handler: @escaping (Result<ProductDetail, ErrorResponses>) -> Void)
}

class ProductDetailManager: IProductDetailManager {
    
    private let comunicationManager = ComunicationManager()
    
    func getProductDetail(productId: String,
                          handler: @escaping (Result<ProductDetail, ErrorResponses>) -> Void) {
        comunicationManager.getProductDetail(forProduct: productId,
                                             handler: handler)
    }
    
}

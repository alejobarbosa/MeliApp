//
//  MockComunicationManager.swift
//  MeliAppTests
//
//  Created by Luis Alejandro Barbosa Lee on 2/04/22.
//

import Foundation
@testable import MeliApp

class MockComunicationManager: ComunicationManager {
    
    var shouldReturnError = false
    var seachProductWasCalled = false
    var getProductDetailWasCalled = false
    var data = Data()
    
    override func searchForProduct(query: String, offset: Int, handler: @escaping (Result<Products, ErrorResponses>) -> Void) {
        self.seachProductWasCalled = true
        if shouldReturnError {
            handler(.failure(.unknownError(nil)))
        } else {
            let serviceResponse: Products
            //Parsing Data
            do {
                serviceResponse = try JSONDecoder().decode(Products.self, from: data)
            } catch {
                let json = String(data: data, encoding: .utf8)
                handler(.failure(.invalidResponse(error, json)))
                return
            }
            handler(.success(serviceResponse))
        }
    }
    
    override func getProductDetail(forProduct productId: String, handler: @escaping (Result<ProductDetail, ErrorResponses>) -> Void) {
        self.getProductDetailWasCalled = true
        if shouldReturnError {
            handler(.failure(.unknownError(nil)))
        } else {
            let serviceResponse: ProductDetail
            //Parsing Data
            do {
                serviceResponse = try JSONDecoder().decode(ProductDetail.self, from: data)
            } catch {
                let json = String(data: data, encoding: .utf8)
                handler(.failure(.invalidResponse(error, json)))
                return
            }
            handler(.success(serviceResponse))
        }
    }
    
}


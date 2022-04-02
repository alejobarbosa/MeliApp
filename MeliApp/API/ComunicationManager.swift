//
//  ComunicationManager.swift
//  MeliApp
//
//  Created by Luis Alejandro Barbosa Lee on 31/03/22.
//

import Foundation
import os.log

class ComunicationManager {
    
    let session = URLSession(configuration: .default)
    
    //MARK: - Get Product List
    func searchForProduct(query: String,
                          offset: Int,
                          handler: @escaping (Result<Products, ErrorResponses>) -> Void) {
        
        //Validation Internet
        if !NetworkManager().validateConnection() {
            handler(.failure(.noInternet(GenericConstants.ErrorView.noConectionMessage)))
        }
        
        //Building URL
        let queryItem = URLQueryItem(name: ServiceConstants.ServiceKeys.queryKey,value: query)
        let offset = URLQueryItem(name: ServiceConstants.ServiceKeys.offsetKey, value: String(offset))
        let path = ServiceConstants.URL().getSearchForProductPath()
        let fullPath = path.replacingOccurrences(of: ServiceConstants.ServiceKeys.siteId, with: ServiceConstants.ServiceCommonHeaders.siteId)
        guard let url = URL(string: fullPath) else {
            Logger.buildingURLError.error("Error creating the URL for search product service call")
            return handler(.failure(.invalidURL))
        }
        
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            Logger.buildingURLError.error("Error creating the URL for search product service call")
            return handler(.failure(.invalidURL))
        }
        components.queryItems = [queryItem, offset]
        guard let composedUrl = components.url else {
            Logger.buildingURLError.error("Error creating the URL for search product service call")
            return handler(.failure(.invalidURL))
        }
        
        //Creating Request
        var request = URLRequest(url: composedUrl)
        request.httpMethod = ServiceConstants.ServiceCommonHeaders.httpGet
        request.setValue(ServiceConstants.ServiceCommonHeaders.applicationJSON,
                         forHTTPHeaderField: ServiceConstants.ServiceCommonHeaders.contentTypeKey)
        request.setValue(ServiceConstants.ServiceCommonHeaders.applicationJSON,
                         forHTTPHeaderField: ServiceConstants.ServiceCommonHeaders.acceptKey)
        
        //Executing Request
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                Logger.callServiceError.error("Search product service error: \(error.localizedDescription)")
                handler(.failure(.unknownError(error)))
                return
            }
            
            //Handling Response
            let httpResposne = response as! HTTPURLResponse
            guard case 200..<300 = httpResposne.statusCode else {
                Logger.callServiceError.error("Search product service error: \(httpResposne.statusCode)")
                handler(.failure(.serviceFailure(httpResposne.statusCode)))
                return
            }
            
            guard let data = data else {
                Logger.dataError.error("Search product service error: Missing Data")
                handler(.failure(.emptyResponse))
                return
            }
            
            let serviceResponse: Products
            
            //Parsing Data
            do {
                serviceResponse = try JSONDecoder().decode(Products.self, from: data)
            } catch {
                Logger.castError.error("Search product casting error: \(error.localizedDescription)")
                let json = String(data: data, encoding: .utf8)
                handler(.failure(.invalidResponse(error, json)))
                return
            }

            handler(.success(serviceResponse))
        }
        task.resume()
    }
    
    //MARK: - Get Product Details
    func getProductDetail(forProduct productId: String,
                          handler: @escaping (Result<ProductDetail, ErrorResponses>) -> Void) {
        //Validation Internet
        if !NetworkManager().validateConnection() {
            handler(.failure(.noInternet(GenericConstants.ErrorView.noConectionMessage)))
        }
        
        //Building URL
        let queryItem = URLQueryItem(name: ServiceConstants.ServiceKeys.includeKey,
                                     value: ServiceConstants.ServiceKeys.allKey)
        let path = ServiceConstants.URL().getProductDetailPath()
        let fullPath = path.replacingOccurrences(of: ServiceConstants.ServiceKeys.itemId, with: productId)
        guard let url = URL(string: fullPath) else {
            Logger.buildingURLError.error("Error creating the URL for get product detail service call")
            return handler(.failure(.invalidURL))
        }
        
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            Logger.buildingURLError.error("Error creating the URL for get product detail service call")
            return handler(.failure(.invalidURL))
        }
        components.queryItems = [queryItem]
        guard let composedUrl = components.url else {
            Logger.buildingURLError.error("Error creating the URL for get product detail service call")
            return handler(.failure(.invalidURL))
        }
        
        //Creating Request
        var request = URLRequest(url: composedUrl)
        request.httpMethod = ServiceConstants.ServiceCommonHeaders.httpGet
        request.setValue(ServiceConstants.ServiceCommonHeaders.applicationJSON,
                         forHTTPHeaderField: ServiceConstants.ServiceCommonHeaders.contentTypeKey)
        request.setValue(ServiceConstants.ServiceCommonHeaders.applicationJSON,
                         forHTTPHeaderField: ServiceConstants.ServiceCommonHeaders.acceptKey)
        
        //Executing Request
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                Logger.callServiceError.error("get product detail service error: \(error.localizedDescription)")
                handler(.failure(.unknownError(error)))
                return
            }
            
            //Handling Response
            let httpResposne = response as! HTTPURLResponse
            guard case 200..<300 = httpResposne.statusCode else {
                Logger.callServiceError.error("get product detail service error: \(httpResposne.statusCode)")
                handler(.failure(.serviceFailure(httpResposne.statusCode)))
                return
            }
            
            guard let data = data else {
                Logger.dataError.error("get product detail service error: Missing Data")
                handler(.failure(.emptyResponse))
                return
            }
            
            let serviceResponse: ProductDetail
            
            //Parsing Data
            do {
                serviceResponse = try JSONDecoder().decode(ProductDetail.self, from: data)
            } catch {
                Logger.castError.error("get product detail parsing error: \(error.localizedDescription)")
                let json = String(data: data, encoding: .utf8)
                handler(.failure(.invalidResponse(error, json)))
                return
            }

            handler(.success(serviceResponse))
        }
        
        task.resume()
    }
    
}

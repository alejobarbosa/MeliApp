//
//  ProductListInteractor.swift
//  MeliApp
//
//  Created by Luis Alejandro Barbosa Lee on 30/03/22.
//  Copyright (c) 2022 Luis Alejandro Barbosa Lee. All rights reserved.

import UIKit
import os.log

protocol IProductListInteractor {
    func searchForProduct(text: String)
    var products: [Product] { get set }
}

class ProductListInteractor: IProductListInteractor {
    var presenter: IProductListPresenter?
    var manager: IProductListManager?
    var paging: Paging?
    var products: [Product] = [] 

    init(presenter: IProductListPresenter, manager: IProductListManager) {
    	self.presenter = presenter
    	self.manager = manager
    }
    
    func searchForProduct(text: String) {
        self.manager?.searchForProduct(text: text,
                                       offset: 0,
                                       handler: { [weak self] (response) in
            switch response {
            case .success(let products):
                DispatchQueue.main.async {
                    self?.paging = products.paging
                    self?.products = products.products
                    self?.presenter?.showData()
                    Logger.searchProductSuccess.info("Showing products for search successfully")
                }
                break
                
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.presenter?.showError(message: self?.getErrorMessage(error: error) ?? "")
                    Logger.searchProductError.error("Error showing products for search")
                }

                break
            }
        })
    }
    
    //MARK: Error Message
    func getErrorMessage(error: ErrorResponses) -> String {
        if !error.localizedDescription.isEmpty {
            return error.localizedDescription
        }
        return "Ocurrió un error inesperado. Por favor intente más tarde"
    }
    
}

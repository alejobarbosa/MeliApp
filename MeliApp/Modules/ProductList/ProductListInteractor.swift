//
//  ProductListInteractor.swift
//  MeliApp
//
//  Created by Luis Alejandro Barbosa Lee on 30/03/22.
//  Copyright (c) 2022 Luis Alejandro Barbosa Lee. All rights reserved.

import UIKit
import os.log

protocol IProductListInteractor: IBaseInteractor {
    func searchForProduct(text: String)
    func getMoreProducts()
    var products: [Product] { get set }
    var isNewCall: Bool { get set }
}

class ProductListInteractor: IProductListInteractor {
    var presenter: IProductListPresenter?
    var manager: IProductListManager?
    var paging: Paging?
    var products: [Product] = []
    var searchedText: String = ""
    var offset: Int = 0
    var isNewCall: Bool = true
    var isLoading: Bool = false

    init(presenter: IProductListPresenter, manager: IProductListManager) {
    	self.presenter = presenter
    	self.manager = manager
    }
    
    //MARK: Service Search Product
    func searchForProduct(text: String) {
        self.isLoading = true
        self.manager?.searchForProduct(text: text,
                                       offset: offset,
                                       handler: { [weak self] (response) in
            switch response {
            case .success(let products):
                DispatchQueue.main.async {
                    self?.paging = products.paging
                    if (self?.isNewCall ?? true) {
                        self?.products = products.products
                    } else {
                        self?.products.append(contentsOf: products.products)
                    }
                    self?.searchedText = text
                    self?.presenter?.showData()
                    self?.isLoading = false
                    Logger.searchProductSuccess.info("Showing products for search successfully")
                }
                break
                
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.presenter?.showError(message: self?.getErrorMessage(error: error) ?? "")
                    self?.isLoading = false
                    Logger.searchProductError.error("Error showing products for search")
                }

                break
            }
        })
    }
    
    //MARK: Service Get More Products
    func getMoreProducts() {
        if !isLoading {
            guard var paging = self.paging else {
                return
            }
            paging.offset = paging.offset + 50
            if paging.offset <= paging.total {
                self.offset = paging.offset
                self.isNewCall = false
                self.searchForProduct(text: self.searchedText)
            }
        }
    }
    
    //MARK: Error Message
    func getErrorMessage(error: ErrorResponses) -> String {
        if !error.localizedDescription.isEmpty {
            return error.localizedDescription
        }
        return GenericConstants.ErrorView.errorMessage
    }
    
}

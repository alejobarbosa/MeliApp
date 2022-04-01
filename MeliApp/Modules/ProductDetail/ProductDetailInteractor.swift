//
//  ProductDetailInteractor.swift
//  MeliApp
//
//  Created by Luis Alejandro Barbosa Lee on 1/04/22.
//  Copyright (c) 2022 Alejandro Barbosa. All rights reserved.

import UIKit
import os.log

protocol IProductDetailInteractor: IBaseInteractor {
	var productId: String! { get set }
}

class ProductDetailInteractor: IProductDetailInteractor {
    var presenter: IProductDetailPresenter?
    var manager: IProductDetailManager?
    var productId: String!
    var productDetail: ProductDetail?

    init(presenter: IProductDetailPresenter,
         manager: IProductDetailManager,
         productId: String) {
    	self.presenter = presenter
    	self.manager = manager
        self.productId = productId
        self.getProductDetail()
    }
    
    func getProductDetail(){
        self.manager?.getProductDetail(productId: self.productId,
                                       handler: { [weak self] (result) in
            switch result {
            case .success(let productDetail):
                self?.productDetail = productDetail
                break
                
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.presenter?.showError(message: self?.getErrorMessage(error: error) ?? "")
                    Logger.showingDetailError.error("Error showing product detail")
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
        return GenericConstants.ErrorView.errorMessage
    }
    
}

//
//  ProductDetailPresenter.swift
//  MeliApp
//
//  Created by Luis Alejandro Barbosa Lee on 1/04/22.
//  Copyright (c) 2022 Alejandro Barbosa. All rights reserved.

import UIKit

protocol IProductDetailPresenter: IBasePresenter {
    func showError(message: String)
}

class ProductDetailPresenter: IProductDetailPresenter {	
	var view: IProductDetailViewController?
	
	init(view: IProductDetailViewController?) {
		self.view = view
	}
    
    func showError(message: String) {
        self.view?.showError(message: message)
    }
}

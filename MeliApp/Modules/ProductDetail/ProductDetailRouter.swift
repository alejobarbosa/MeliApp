//
//  ProductDetailRouter.swift
//  MeliApp
//
//  Created by Luis Alejandro Barbosa Lee on 1/04/22.
//  Copyright (c) 2022 Alejandro Barbosa. All rights reserved.

import UIKit

protocol IProductDetailRouter: IBaseRouter {
    func navigateToPreviousVC()
}

class ProductDetailRouter: IProductDetailRouter {	
	weak var view: ProductDetailViewController?
	
	init(view: ProductDetailViewController?) {
		self.view = view
	}
    
    func navigateToPreviousVC() {
        self.view?.navigationController?.popViewController(animated: true)
    }
}

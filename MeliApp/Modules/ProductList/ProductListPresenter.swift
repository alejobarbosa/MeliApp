//
//  ProductListPresenter.swift
//  MeliApp
//
//  Created by Luis Alejandro Barbosa Lee on 30/03/22.
//  Copyright (c) 2022 Luis Alejandro Barbosa Lee. All rights reserved.

import UIKit

protocol IProductListPresenter: IBasePresenter {
    func showError(message: String)
    func showData()
}

class ProductListPresenter: IProductListPresenter {	
	var view: IProductListViewController?
	
	init(view: IProductListViewController?) {
		self.view = view
	}
    
    func showError(message: String) {
        self.view?.showError(message: message)
    }
    
    func showData() {
        self.view?.showData()
    }
}

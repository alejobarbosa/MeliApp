//
//  ProductListRouter.swift
//  MeliApp
//
//  Created by Luis Alejandro Barbosa Lee on 30/03/22.
//  Copyright (c) 2022 Luis Alejandro Barbosa Lee. All rights reserved.

import UIKit

protocol IProductListRouter: class {
	// do someting...
}

class ProductListRouter: IProductListRouter {	
	weak var view: ProductListViewController?
	
	init(view: ProductListViewController?) {
		self.view = view
	}
}

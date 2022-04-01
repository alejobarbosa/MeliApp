//
//  HomeRouter.swift
//  MeliApp
//
//  Created by Luis Alejandro Barbosa Lee on 30/03/22.
//  Copyright (c) 2022 Luis Alejandro Barbosa Lee. All rights reserved.

import UIKit

protocol IHomeRouter: AnyObject {
    func navigateToProductList()
}

class HomeRouter: IHomeRouter {	
	weak var view: HomeViewController?
	
	init(view: HomeViewController?) {
		self.view = view
	}
    
    func navigateToProductList(){
        self.view?.navigationController?.pushViewController(ProductListConfiguration.setup(), animated: true)
    }
}

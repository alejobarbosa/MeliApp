//
//  HomeRouter.swift
//  MeliApp
//
//  Created by Luis Alejandro Barbosa Lee on 30/03/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

protocol IHomeRouter: class {
	// do someting...
}

class HomeRouter: IHomeRouter {	
	weak var view: HomeViewController?
	
	init(view: HomeViewController?) {
		self.view = view
	}
}

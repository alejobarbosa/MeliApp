//
//  BaseRouter.swift
//  MeliApp
//
//  Created by Luis Alejandro Barbosa Lee on 1/04/22.
//  Copyright (c) 2022 Alejandro Barbosa. All rights reserved.

import UIKit

protocol IBaseRouter {
	
}

class BaseRouter: IBaseRouter {	
	weak var view: BaseViewController?
	
	init(view: BaseViewController?) {
		self.view = view
	}
}

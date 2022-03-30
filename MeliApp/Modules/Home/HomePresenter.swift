//
//  HomePresenter.swift
//  MeliApp
//
//  Created by Luis Alejandro Barbosa Lee on 30/03/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

protocol IHomePresenter: class {
}

class HomePresenter: IHomePresenter {	
	weak var view: IHomeViewController?
	
	init(view: IHomeViewController?) {
		self.view = view
	}
}

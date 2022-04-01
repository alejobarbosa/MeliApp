//
//  HomePresenter.swift
//  MeliApp
//
//  Created by Luis Alejandro Barbosa Lee on 30/03/22.
//  Copyright (c) 2022 Luis Alejandro Barbosa Lee. All rights reserved.

import UIKit

protocol IHomePresenter {
}

class HomePresenter: IHomePresenter {	
	var view: IHomeViewController?
	
	init(view: IHomeViewController?) {
		self.view = view
	}
}

//
//  BaseInteractor.swift
//  MeliApp
//
//  Created by Luis Alejandro Barbosa Lee on 1/04/22.
//  Copyright (c) 2022 Alejandro Barbosa. All rights reserved.

import UIKit

protocol IBaseInteractor {

}

class BaseInteractor: IBaseInteractor {
    var presenter: IBasePresenter?
    var manager: IBaseManager?

    init(presenter: IBasePresenter, manager: IBaseManager) {
    	self.presenter = presenter
    	self.manager = manager
    }
}

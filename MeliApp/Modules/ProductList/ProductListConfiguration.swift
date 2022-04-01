//
//  ProductListConfiguration.swift
//  MeliApp
//
//  Created by Luis Alejandro Barbosa Lee on 30/03/22.
//  Copyright (c) 2022 Luis Alejandro Barbosa Lee. All rights reserved.

import Foundation
import UIKit

class ProductListConfiguration {
    static func setup() -> UIViewController {
        let controller = ProductListViewController()
        let router = ProductListRouter(view: controller)
        let presenter = ProductListPresenter(view: controller)
        let manager = ProductListManager()
        let interactor = ProductListInteractor(presenter: presenter, manager: manager)
        
        controller.interactor = interactor
        controller.router = router
        return controller
    }
}

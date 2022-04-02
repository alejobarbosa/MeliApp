//
//  ProductDetailConfiguration.swift
//  MeliApp
//
//  Created by Luis Alejandro Barbosa Lee on 1/04/22.
//  Copyright (c) 2022 Alejandro Barbosa. All rights reserved.

import Foundation
import UIKit

class ProductDetailConfiguration {
    static func setup(productId: String, installment: Installment?) -> UIViewController {
        let controller = ProductDetailViewController()
        let router = ProductDetailRouter(view: controller)
        let presenter = ProductDetailPresenter(view: controller)
        let manager = ProductDetailManager()
        let interactor = ProductDetailInteractor(presenter: presenter,
                                                 manager: manager,
                                                 productId: productId,
                                                 installment: installment
        )
        
        controller.interactor = interactor
        controller.router = router
        return controller
    }
}

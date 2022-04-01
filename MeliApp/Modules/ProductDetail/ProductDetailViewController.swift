//
//  ProductDetailViewController.swift
//  MeliApp
//
//  Created by Luis Alejandro Barbosa Lee on 1/04/22.
//  Copyright (c) 2022 Alejandro Barbosa. All rights reserved.

import UIKit

protocol IProductDetailViewController {
	var router: IProductDetailRouter? { get set }
    func showError(message: String)
    func showData(productDetail: ProductDetail)
}

class ProductDetailViewController: BaseViewController {
	var interactor: IProductDetailInteractor?
	var router: IProductDetailRouter?

	override func viewDidLoad() {
        super.viewDidLoad()
        self.showActivityIndicator(show: true)
    }
}

extension ProductDetailViewController: IProductDetailViewController {
    func showError(message: String) {
        self.showActivityIndicator(show: false)
        self.showErrorView(message: message, handlerAccept: { _ in
            self.router?.navigateToPreviousVC()
        })
    }
    func showData(productDetail: ProductDetail) {
        self.showActivityIndicator(show: false)
    }
}

//
//  ProductDetailInteractor.swift
//  MeliApp
//
//  Created by Luis Alejandro Barbosa Lee on 1/04/22.
//  Copyright (c) 2022 Alejandro Barbosa. All rights reserved.

import UIKit
import os.log

protocol IProductDetailInteractor: IBaseInteractor {
	var productId: String! { get set }
}

class ProductDetailInteractor: IProductDetailInteractor {
    var presenter: IProductDetailPresenter?
    var manager: IProductDetailManager?
    var productId: String!
    var productDetail: ProductDetail?
    var installment: Installment?

    init(presenter: IProductDetailPresenter,
         manager: IProductDetailManager,
         productId: String,
         installment: Installment?) {
    	self.presenter = presenter
    	self.manager = manager
        self.productId = productId
        self.installment = installment
        self.getProductDetail()
    }
    
    func getProductDetail(){
        self.manager?.getProductDetail(productId: self.productId,
                                       handler: { [weak self] (result) in
            switch result {
            case .success(let productDetail):
                self?.productDetail = productDetail
                self?.getImages(fromURLs: productDetail.detailImages.map { $0.url }) { images in
                    self?.presenter?.showData(productDetail: productDetail,
                                              images: images,
                                              installment: self?.installment)
                }
                break
                
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.presenter?.showError(message: self?.getErrorMessage(error: error) ?? "")
                    Logger.showingDetailError.error("Error showing product detail")
                }
                break
            }
        })
    }
    
    //MARK: Error Message
    func getErrorMessage(error: ErrorResponses) -> String {
        if !error.localizedDescription.isEmpty {
            return error.localizedDescription
        }
        return GenericConstants.ErrorView.errorMessage
    }
    
    //MARK: Images
    ///Method to get images from URL strings
    func getImages(fromURLs urls: [String], completion: @escaping ([UIImage]) -> Void) {
        let group = DispatchGroup()
        var images: [UIImage] =  .init(repeating: UIImage(), count: urls.count)
        
        for (index, urlString) in urls.enumerated() {
            group.enter()
            DispatchQueue.global().async {
                var image: UIImage?
                if let url = URL(string: urlString) {
                    if let data = try? Data(contentsOf: url) {
                        image = UIImage(data: data)
                    }
                }
                images[index] = image ?? UIImage()
                group.leave()
            }
        }
        group.notify(queue: .main) {
            completion(images)
        }
    }
    
}

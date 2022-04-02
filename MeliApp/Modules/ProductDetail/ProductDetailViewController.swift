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
    func showData(productDetail: ProductDetail,
                  images: [UIImage],
                  installment: Installment?)
}

class ProductDetailViewController: BaseViewController {
    
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var viewPaging: UIView!
    @IBOutlet weak var lblPage: UILabel!
    @IBOutlet weak var viewScroll: UIView!
    @IBOutlet weak var viewColor: UIView!
    @IBOutlet weak var viewColorCurve: UIView!
    @IBOutlet weak var lblColor: UILabel!
    @IBOutlet weak var lblOriginalPrice: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var viewInstallment: UIView!
    @IBOutlet weak var lblInstallment: UILabel!
    @IBOutlet weak var viewShipping: UIView!
    @IBOutlet weak var imgShipping: UIImageView!
    @IBOutlet weak var lblShipping: UILabel!
    @IBOutlet weak var viewPickUp: UIView!
    @IBOutlet weak var lblPickUp: UILabel!
    
	var interactor: IProductDetailInteractor?
	var router: IProductDetailRouter?

	override func viewDidLoad() {
        super.viewDidLoad()
        self.showActivityIndicator(show: true)
        self.viewColorCurve.layer.cornerRadius = 10
        self.viewPaging.layer.cornerRadius = 12.5
        self.embedInScroll(self.viewMain, height: 700)
    }
    
    //MARK: - Set Up Scroll Images
    private func setUpScrollImages(with images: [UIImage]){
        let scrollView = UIScrollView(frame: CGRect(x: 0,
                                                    y: 0,
                                                    width: self.viewScroll.frame.width,
                                                    height: self.viewScroll.frame.height))
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        for i in 0..<images.count {
            let imageView = UIImageView()
            imageView.image = images[i]
            imageView.contentMode = .scaleAspectFit
            let xPosition = self.viewScroll.frame.width * CGFloat(i)
            imageView.frame = CGRect(x: xPosition,
                                     y: 0,
                                     width: scrollView.frame.width,
                                     height: scrollView.frame.height)
            scrollView.contentSize.width = scrollView.frame.width * (CGFloat(i + 1))
            scrollView.addSubview(imageView)
        }
        self.viewScroll.addSubview(scrollView)
        self.viewPaging.isHidden = false
        self.lblPage.text = ProductDetailModel.Constants.firstPage + images.count.description
    }
    
    // MARK: - Get Product Installment
    ///Method to fortmat the installment to currency
    func getProductInterests(installment: Installment?) -> String {
        let numberOfPayments = installment?.quantity ?? 0
        let amount = installment?.amount ?? 0.0
        let amountStrig = amount.getCurrencyString()
        return GenericConstants.inStr + String(numberOfPayments) + GenericConstants.xStr + amountStrig
    }
    
}

extension ProductDetailViewController: UIScrollViewDelegate{
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let totalPages = Int(scrollView.contentSize.width / self.viewScroll.frame.width)
        let currentPage = Int(scrollView.contentOffset.x / self.viewScroll.frame.width) + 1
        self.lblPage.text = currentPage.description + ProductDetailModel.Constants.divider + totalPages.description
    }
}

extension ProductDetailViewController: IProductDetailViewController {
    
    //MARK: - Show Error View
    func showError(message: String) {
        self.showActivityIndicator(show: false)
        self.showErrorView(message: message, handlerAccept: { _ in
            self.router?.navigateToPreviousVC()
        })
    }
    
    //MARK: - Set Up Data
    func showData(productDetail: ProductDetail,
                  images: [UIImage],
                  installment: Installment?) {
        self.showActivityIndicator(show: false)
        self.setUpScrollImages(with: images)
        
        ///Setting status
        self.lblStatus.text = productDetail.condition == ProductDetailModel.Constants.newEn ?
                                                            ProductDetailModel.Constants.newSp :
                                                            ProductDetailModel.Constants.used
        ///Setting name
        self.lblName.text = productDetail.title
        
        ///Setting color
        if let attributes = productDetail.attributes,
           !(attributes.filter({$0.id == ProductDetailModel.Constants.color}).isEmpty),
            let colorModel = attributes.filter({$0.id == ProductDetailModel.Constants.color}).first{
            self.viewColor.isHidden = false
            self.lblColor.text = colorModel.valueName
        }
        
        ///Setting original price
        if let originalPrice = productDetail.originalPrice{
            let originalPriceStr = originalPrice.getCurrencyString()
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: originalPriceStr)
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle,
                                         value: 2,
                                         range: NSMakeRange(0, attributeString.length))
            self.lblOriginalPrice.attributedText = attributeString
        }
        
        ///Setting price
        self.lblPrice.text = productDetail.price.getCurrencyString()
        
        ///Setting installment
        if let i = installment {
            self.viewInstallment.isHidden = false
            if i.rate == 0 {
                self.lblInstallment.text = ProductDetailModel.Constants.installment
            } else {
                let installmentStr = self.getProductInterests(installment: installment)
                self.lblInstallment.attributedText = installmentStr.getInstallmentAttributed(hasInterest: true, isForDetail: true)
            }
        }
        
        ///Setting shipping
        if productDetail.shipping.freeShipping {
            self.imgShipping.tintColor = .AppColor.green
            self.lblShipping.textColor = .AppColor.green
            self.lblShipping.text = ProductDetailModel.Constants.freeShipping
        } else {
            self.imgShipping.tintColor = .black
            self.lblShipping.textColor = .black
            self.lblShipping.text = ProductDetailModel.Constants.shippingCost
        }
        self.viewShipping.isHidden = false
        
        ///Setting pick up
        if let localPickUp = productDetail.shipping.localPickUp {
            self.viewPickUp.isHidden = localPickUp
        }
    }
}

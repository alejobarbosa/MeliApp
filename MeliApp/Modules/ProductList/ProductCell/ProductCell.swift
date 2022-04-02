//
//  ProductCell.swift
//  MeliApp
//
//  Created by Luis Alejandro Barbosa Lee on 31/03/22.
//

import UIKit

class ProductCell: UITableViewCell {
    
    @IBOutlet weak var viewContnent: UIView!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblInstallment: UILabel!
    @IBOutlet weak var lblShipping: UILabel!
    static let height:CGFloat = 200

    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewContnent.layer.cornerRadius = 10
        self.imgProduct.layer.cornerRadius = 10
    }
    
    func setData(product: Product){
        self.imgProduct.loadFromURL(product.image ?? "")
        self.lblName.text = product.title
        self.setPriceLabel(price: product.price, currency: product.currency)
        self.setInstallmentLabel(installment: product.installments)
        self.lblShipping.isHidden = !(product.shipping?.freeShipping ?? false)
    }
    
    // MARK: - Set Price Label
    ///Method to set the text for the price label
    private func setPriceLabel(price: Double, currency: String){
        let priceString = price.getCurrencyString() + currency
        var mutablePriceString = NSMutableAttributedString()
        mutablePriceString = NSMutableAttributedString(string: priceString,
                                                       attributes: [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 22)])
        mutablePriceString.addAttribute(NSAttributedString.Key.foregroundColor,
                                   value: UIColor.AppColor.green,
                                   range: NSRange(location: priceString.count - 3,
                                                  length:3))
        
        mutablePriceString.addAttribute(NSAttributedString.Key.font,
                                   value: UIFont.systemFont(ofSize: 15),
                                   range: NSRange(location: priceString.count - 3,
                                                  length:3))
        self.lblPrice.attributedText = mutablePriceString
        self.lblPrice.adjustsFontSizeToFitWidth = true
    }
    
    // MARK: - Set Installment Label
    ///Method to set the text for the installment label
    private func setInstallmentLabel(installment: Installment?) {
        let installmentString = self.getProductInterests(installment: installment)
        let hasInterestRate = installment?.rate ?? 1 == 0 ? false : true
        self.lblInstallment.attributedText = installmentString.getInstallmentAttributed(hasInterest: hasInterestRate, isForDetail: false)
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

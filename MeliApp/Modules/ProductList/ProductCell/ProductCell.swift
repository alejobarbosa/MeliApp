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
    
    ///Method to set the text for the price label
    private func setPriceLabel(price: Double, currency: String){
        let priceString = self.getProductPrice(price: price) + currency
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
    
    ///Method to set the text for the installment label
    private func setInstallmentLabel(installment: Installment?) {
        var installmentString = self.getProductInterests(installment: installment)
        let hasInterestRate = installment?.rate ?? 1 == 0 ? false : true
        installmentString = !hasInterestRate ? installmentString + " sin interés" : installmentString
        var mutablePriceString = NSMutableAttributedString()
        mutablePriceString = NSMutableAttributedString(string: installmentString,
                                                       attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 12)])
        if !hasInterestRate {
            
            mutablePriceString.addAttribute(NSAttributedString.Key.foregroundColor,
                                       value: UIColor.AppColor.green,
                                       range: NSRange(location: 2,
                                                      length: installmentString.count - 2))
        }
        self.lblInstallment.attributedText = mutablePriceString
    }
    
    ///Method to fortmat the price to currency
    private func getProductPrice(price: Double) -> String{
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "$ "
        formatter.currencyGroupingSeparator = "."
        formatter.maximumFractionDigits = 0
        let priceString = formatter.string(from: NSNumber(value: price)) ?? "$ 0"
        return priceString
    }
    
    ///Method to fortmat the installment to currency
    func getProductInterests(installment: Installment?) -> String {
        let numberOfPayments = installment?.quantity ?? 0
        let amount = installment?.amount ?? 0.0
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "$ "
        formatter.currencyGroupingSeparator = "."
        formatter.maximumFractionDigits = 0
        let amountStrig = formatter.string(from: NSNumber(value: amount)) ?? "$ 0"
        return "en " + String(numberOfPayments) + "x " + amountStrig
    }
    
}

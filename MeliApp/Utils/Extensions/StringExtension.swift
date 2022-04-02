//
//  StringExtension.swift
//  MeliApp
//
//  Created by Luis Alejandro Barbosa Lee on 1/04/22.
//

import UIKit

extension String {
    
    func getInstallmentAttributed(hasInterest: Bool, isForDetail: Bool) -> NSMutableAttributedString{
        var installmentString = self
        installmentString = !hasInterest ? installmentString + GenericConstants.noInterest : installmentString
        var mutablePriceString = NSMutableAttributedString()
        mutablePriceString = NSMutableAttributedString(string: installmentString,
                                                       attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 12)])
        if !hasInterest {
            
            mutablePriceString.addAttribute(NSAttributedString.Key.foregroundColor,
                                       value: UIColor.AppColor.green,
                                       range: NSRange(location: 2,
                                                      length: installmentString.count - 2))
        }
        return mutablePriceString
    }
    
}

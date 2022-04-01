//
//  Installment.swift
//  MeliApp
//
//  Created by Luis Alejandro Barbosa Lee on 31/03/22.
//

import Foundation

struct Installment: Codable {
    var quantity: Int
    var amount: Double
    var rate: Double
    var currency: String
    
    enum CodingKeys: String, CodingKey {
        case quantity
        case amount
        case rate
        case currency =  "currency_id"
    }
}

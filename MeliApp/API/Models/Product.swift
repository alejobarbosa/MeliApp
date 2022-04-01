//
//  Product.swift
//  MeliApp
//
//  Created by Luis Alejandro Barbosa Lee on 31/03/22.
//

import Foundation

struct Product: Codable, Identifiable {
    var id: String
    var siteId: String
    var title: String
    var price: Double
    var currency: String
    var availability: Int?
    var soldQuantity: Int?
    var image: String?
    var installments: Installment?
    var shipping: Shipping?

    enum CodingKeys: String, CodingKey {
        case id
        case siteId = "site_id"
        case title
        case price
        case currency = "currency_id"
        case availability = "available_quantity"
        case soldQuantity = "sold_quantity"
        case image = "thumbnail"
        case installments
        case shipping
    }
    
}

//
//  ProductDetail.swift
//  MeliApp
//
//  Created by Luis Alejandro Barbosa Lee on 31/03/22.
//

import Foundation

struct ProductDetail: Codable {
    var id: String
    var title: String
    var price: Double
    var basePrice: Double
    var originalPrice: Double?
    var currency: String
    var availability: Int
    var detailImages: [DetailImage]
    var shipping: Shipping
    var condition: String?
    var attributes: [Attribute]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case price
        case basePrice = "base_price"
        case originalPrice = "original_price"
        case currency = "currency_id"
        case availability = "available_quantity"
        case detailImages = "pictures"
        case shipping
        case condition
        case attributes
    }
}
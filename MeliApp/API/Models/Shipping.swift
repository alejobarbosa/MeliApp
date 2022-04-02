//
//  Shipping.swift
//  MeliApp
//
//  Created by Luis Alejandro Barbosa Lee on 31/03/22.
//

import Foundation

struct Shipping: Codable {
    
    var freeShipping: Bool
    var storePickUp: Bool
    var mode: String
    var tags: [String]
    var logistic_type: String
    var localPickUp: Bool?
    
    enum CodingKeys: String, CodingKey {
        case freeShipping = "free_shipping"
        case storePickUp = "store_pick_up"
        case mode
        case tags
        case logistic_type
        case localPickUp = "local_pick_up"
    }
}

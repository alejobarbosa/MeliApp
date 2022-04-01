//
//  Products.swift
//  MeliApp
//
//  Created by Luis Alejandro Barbosa Lee on 31/03/22.
//

import Foundation

struct Products: Codable {
    var siteId: String
    var paging: Paging
    var products: [Product]
    
    enum CodingKeys: String, CodingKey {
        case siteId = "site_id"
        case paging
        case products = "results"
    }
}

enum ProductServiceType {
    case categoryProducts
    case searchProducts
}

//
//  ServiceConstants.swift
//  MeliApp
//
//  Created by Luis Alejandro Barbosa Lee on 31/03/22.
//

import Foundation
 
struct ServiceConstants {
    
    ///Keys to use in the calls of serices
    struct ServiceKeys {
        static let queryKey = "q"
        static let categoryKey = "category"
        static let offsetKey = "offset"
        static let siteId = "{SITE_ID}"
        static let itemId = "{ITEM_ID}"
        static let allKey = "all"
        static let includeKey = "include_attributes"
    }
    
    ///Builder to get the each url
    struct URL {
        var domain: String = ""
        
        init() {
            self.domain = getMainDomain()
        }
        
        func getMainDomain() -> String {
            return "https://api.mercadolibre.com"
        }
        
        func getSearchForProductPath() -> String {
            return domain + "/sites/{SITE_ID}/search"
        }
        
        func getProductDetailPath() -> String {
            return domain + "/items/{ITEM_ID}"
        }
        
        func getProductDescription() -> String {
            return domain + "/items/{ITEM_ID}/descriptions"
        }
        
    }
    
    ///Common values used in services request
    enum ServiceCommonHeaders {
        static let httpGet = "GET"
        static let applicationJSON = "application/json"
        static let contentTypeKey = "Content-Type"
        static let acceptKey = "Accept"
        static let siteId = "MCO"
    }
    
    
}

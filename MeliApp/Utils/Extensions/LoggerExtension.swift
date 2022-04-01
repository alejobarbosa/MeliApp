//
//  LoggerExtension.swift
//  MeliApp
//
//  Created by Luis Alejandro Barbosa Lee on 31/03/22.
//

import Foundation
import os.log

/// Extension for error handling
extension Logger {
    private static var subsystem = Bundle.main.bundleIdentifier!
    
    ///Logs to call - receive services
    static let castError = Logger(subsystem: subsystem, category: GenericConstants.LoggerCategories.cast)
    static let callServiceError = Logger(subsystem: subsystem, category: GenericConstants.LoggerCategories.callService)
    static let buildingURLError = Logger(subsystem: subsystem, category: GenericConstants.LoggerCategories.buildURL)
    static let dataError = Logger(subsystem: subsystem, category: GenericConstants.LoggerCategories.dataError)
    
    ///Logs product list service
    static let searchProductError = Logger(subsystem: subsystem, category: GenericConstants.LoggerCategories.searchProduct)
    static let searchProductSuccess = Logger(subsystem: subsystem, category: GenericConstants.LoggerCategories.searchProduct)
    
    ///Logs to show product detail
    static let showingDetailError = Logger(subsystem: subsystem, category: GenericConstants.LoggerCategories.showingDetail)
    static let showingDetailSuccess = Logger(subsystem: subsystem, category: GenericConstants.LoggerCategories.showingDetail)
}

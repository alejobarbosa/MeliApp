//
//  ErrorConstants.swift
//  MeliApp
//
//  Created by Luis Alejandro Barbosa Lee on 1/04/22.
//

import Foundation

struct GenericConstants {
    
    //MARK: Error View
    struct ErrorView {
        static let errorTitle = "¡Ups!"
        static let errorMessage = "Ocurrió un error inesperado. Por favor intente más tarde"
    }
    
    //MARK: Logs Categories
    struct LoggerCategories {
        
        ///Categories to call - receive services
        static let cast = "cast"
        static let callService = "callService"
        static let buildURL = "buildURL"
        static let dataError = "dataError"
        
        ///Categorie to product list service
        static let searchProduct = "searchProduct"
        
        ///Categorie to show product detail
        static let showingDetail = "showingDetail"
    }
    
    //MARK: Generic
    static let acceptTitle = "Aceptar"
    
    
}

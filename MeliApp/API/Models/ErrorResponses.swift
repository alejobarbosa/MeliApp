//
//  ErrorResponses.swift
//  MeliApp
//
//  Created by Luis Alejandro Barbosa Lee on 31/03/22.
//

import Foundation

enum ErrorResponses: Error {
    case invalidURL
    case emptyResponse
    case serviceFailure(Int)
    case invalidResponse(Error, String?)
    case unknownError(Error?)
    case noInternet(String)
}

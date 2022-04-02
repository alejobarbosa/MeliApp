//
//  Attributes.swift
//  MeliApp
//
//  Created by Luis Alejandro Barbosa Lee on 1/04/22.
//

import Foundation

struct Attribute: Codable {
    let id: String
    let name: String
    let valueName: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case valueName = "value_name"
    }
}

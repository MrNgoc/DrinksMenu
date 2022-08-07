//
//  Model.swift
//  DrinksMenu
//
//  Created by NGOCDT16 on 03/08/2022.
//

import Foundation

struct Drink: Codable, Equatable {
    let _id: String
    let image: String
    let instructions: String
    let name: String
    
    private enum CodingKeys: String, CodingKey {
        case image = "strDrinkThumb"
        case instructions = "strInstructions"
        case name = "strDrink"
        case _id = "idDrink"
    }
}

struct Drinks: Codable {
    let model: [Drink]
    private enum CodingKeys: String, CodingKey {
        case model = "drinks"
    }
}

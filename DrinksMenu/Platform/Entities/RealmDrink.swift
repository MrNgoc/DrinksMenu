//
//  RealmDrink.swift
//  DrinksMenu
//
//  Created by NGOCDT16 on 06/08/2022.
//

import Foundation
import RealmSwift

class DrinkModel: Object {
    @Persisted(primaryKey: true) var _id: String
    @Persisted var image: String
    @Persisted var instructions: String
    @Persisted var name: String
    
    convenience init(_id: String, image: String, instructions: String, name: String) {
        self.init()
        self._id = _id
        self.image = image
        self.instructions = instructions
        self.name = name
    }
    
    func unmanage() -> DrinkModel {
        return DrinkModel(value: self)
    }
    
    func toDrink() -> Drink {
        return Drink(_id: _id, image: image, instructions: instructions, name: name)
    }
}

extension Drink {
    func toRealm() -> DrinkModel {
        return DrinkModel(_id: self._id, image: self.image, instructions: self.instructions, name: self.name)
    }
}

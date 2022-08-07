//
//  DrinksUseCaseMock.swift
//  DrinksMenuTests
//
//  Created by NGOCDT16 on 06/08/2022.
//

import Foundation
@testable import DrinksMenu
import RxSwift

class DrinksUseCaseMock: DrinksUseCaseType {
    var drinks_ReturnValue: Observable<[Drink]> = Observable.just([])
    var drinks_Called = false
    func getDrinks() -> Observable<[Drink]> {
        drinks_Called = true
        return drinks_ReturnValue
    }
}

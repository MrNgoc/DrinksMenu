//
//  DrinkUseCase.swift
//  DrinksMenu
//
//  Created by NGOCDT16 on 06/08/2022.
//

import Foundation
import RxSwift

protocol DrinksUseCaseType {
    func getDrinks() -> Observable<[Drink]>
}

protocol UseCaseProviderType {
    func makeDrinksUseCase() -> DrinksUseCaseType
}

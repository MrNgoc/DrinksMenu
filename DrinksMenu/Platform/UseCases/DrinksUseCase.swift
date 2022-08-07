//
//  DrinksUseCase.swift
//  DrinksMenu
//
//  Created by NGOCDT16 on 06/08/2022.
//
import RxSwift

final class DrinksUseCase: DrinksUseCaseType {
    private let service: DrinksMenuServiceType
    
    init(service: DrinksMenuServiceType = DrinksMenuService.shared) {
        self.service = service
    }
    
    func getDrinks() -> Observable<[Drink]> {
        let cache = service.observableDrinkMenu().filter { !$0.isEmpty }
        let stored = service.getDrinksMenu()
        return Observable.merge(cache, stored)
    }
}

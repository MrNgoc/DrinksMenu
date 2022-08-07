//
//  UseCaseProvider.swift
//  DrinksMenu
//
//  Created by NGOCDT16 on 06/08/2022.
//

import Foundation
import RxSwift

final class UseCaseProvider: UseCaseProviderType {
    func makeDrinksUseCase() -> DrinksUseCaseType {
        return DrinksUseCase()
    }
}

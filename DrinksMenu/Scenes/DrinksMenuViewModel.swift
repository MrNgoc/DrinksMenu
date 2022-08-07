//
//  DrinksMenuViewModel.swift
//  DrinksMenu
//
//  Created by NGOCDT16 on 03/08/2022.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

final class DrinksMenuViewModel: ViewModelType {
    private let useCase: DrinksUseCaseType
    
    init(useCase: DrinksUseCaseType) {
        self.useCase = useCase
    }
    
    func transform(input: Input) -> Output {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        let drinks = input.trigger.flatMapLatest { () -> Driver<[Drink]> in
            return self.useCase.getDrinks()
                .trackActivity(activityIndicator)
                .trackError(errorTracker)
                .asDriverOnErrorJustComplete()
                .distinctUntilChanged()
        }
    
        let errors = errorTracker.asDriver()
        return Output(fetching: activityIndicator.asDriver(), drinks: drinks, error: errors)
    }
    
    struct Input {
        let trigger: Driver<Void>
    }
    
    struct Output {
        let fetching: Driver<Bool>
        let drinks: Driver<[Drink]>
        let error: Driver<Error>
    }
    
}


//
//  DrinksMenuTests.swift
//  DrinksMenuTests
//
//  Created by NGOCDT16 on 03/08/2022.
//

import XCTest
@testable import DrinksMenu
import RxSwift
import RxCocoa

enum TestError: Error {
  case test
}

class DrinksMenuTests: XCTestCase {
    
    var viewModel: DrinksMenuViewModel!
    var useCase: DrinksUseCaseMock!
    let disposeBag = DisposeBag()

    override func setUpWithError() throws {
        useCase = DrinksUseCaseMock()
        viewModel = DrinksMenuViewModel(useCase: useCase)
    }
    
    func test_transform_triggerInvoked_drinksEmited() {
        // arrange
        let trigger = PublishSubject<Void>()
        let input = DrinksMenuViewModel.Input(trigger: trigger.asDriverOnErrorJustComplete())
        let output = viewModel.transform(input: input)
        
        // act
        output.drinks.drive().disposed(by: disposeBag)
        trigger.onNext(())
        
        // assert
        XCTAssert(useCase.drinks_Called)
    }
    
    func test_transform_sendDrinks_trackFetching() {
      // arrange
        let trigger = PublishSubject<Void>()
        let input = DrinksMenuViewModel.Input(trigger: trigger.asDriverOnErrorJustComplete())
        let output = viewModel.transform(input: input)
        let expectedFetching = [true, false]
        var actualFetching: [Bool] = []

      // act
      output.fetching
        .do(onNext: { actualFetching.append($0) },
            onSubscribe: { actualFetching.append(true) })
        .drive()
        .disposed(by: disposeBag)
      trigger.onNext(())

      // assert
      XCTAssertEqual(actualFetching, expectedFetching)
    }
    
    func test_transform_drinksEmitError_trackError() {
        // arrange
        let trigger = PublishSubject<Void>()
        let input = DrinksMenuViewModel.Input(trigger: trigger.asDriverOnErrorJustComplete())
        let output = viewModel.transform(input: input)
        useCase.drinks_ReturnValue = Observable.error(TestError.test)
        var hasError = false
        
        // act
        output.drinks.drive().disposed(by: disposeBag)
        output.error.drive { error in
            hasError = true
        }.disposed(by: disposeBag)
        
        trigger.onNext(())
        // assert
        XCTAssert(hasError)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

}

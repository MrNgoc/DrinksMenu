//
//  Application.swift
//  DrinksMenu
//
//  Created by NGOCDT16 on 06/08/2022.
//

import UIKit

final class Application {
    static let shared = Application()
    private let useCacheProvider: UseCaseProvider
    
    private init() {
        self.useCacheProvider = UseCaseProvider()
    }
    
    func configureMainInterface(in window: UIWindow) {
        let viewController = DrinksMenuViewController()
        viewController.viewModel = DrinksMenuViewModel(useCase: useCacheProvider.makeDrinksUseCase())
        window.rootViewController = UINavigationController(rootViewController: viewController)
        window.makeKeyAndVisible()
    }
}

//
//  AppDelegate.swift
//  DrinksMenu
//
//  Created by NGOCDT16 on 03/08/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        Application.shared.configureMainInterface(in: window!)
      
        return true
    }

}

//
//  AppDelegate.swift
//  fetch
//
//  Created by Prince Avecillas on 6/20/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: RecipesCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let navigationController = UINavigationController()
        coordinator = RecipesCoordinator(navigationController: navigationController)
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        window.backgroundColor = .systemBackground
        window.rootViewController = navigationController
        self.window = window
                
        coordinator?.start()

        return true
    }
}


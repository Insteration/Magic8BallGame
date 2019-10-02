//
//  AppDelegate.swift
//  Magic8BallGame
//
//  Created by Artem Karma on 8/15/19.
//  Copyright © 2019 Johansson Group. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var navigatioonController: UINavigationController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        self.window = UIWindow(frame: UIScreen.main.bounds)

        if let window = window {
            let mainVC = BallViewController()
            navigatioonController = UINavigationController(rootViewController: mainVC)
            window.rootViewController = navigatioonController
            window.makeKeyAndVisible()
        }
        return true
    }
}

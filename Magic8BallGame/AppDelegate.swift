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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        self.window = UIWindow(frame: UIScreen.main.bounds)

        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "BallViewController") as? BallViewController
        let navigationController = UINavigationController.init(rootViewController: mainViewController!)
        self.window?.rootViewController = navigationController

        self.window?.makeKeyAndVisible()
        return true
    }
}

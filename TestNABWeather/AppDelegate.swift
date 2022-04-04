//
//  AppDelegate.swift
//  TestNABWeather
//
//  Created by tungphan on 31/03/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let listWeatherVC = ListWeatherViewController.create()
        let navVC = UINavigationController(rootViewController: listWeatherVC)
        self.window?.rootViewController = navVC
        self.window?.makeKeyAndVisible()
        return true
    }


}


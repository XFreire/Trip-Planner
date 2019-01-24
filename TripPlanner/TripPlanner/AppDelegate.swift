//
//  AppDelegate.swift
//  TripPlanner
//
//  Created by Alexandre Freire on 24/01/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let appAssembly = AppAssembly()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let initialViewController = appAssembly.coreAssembly.searchAssembly.viewController()
        
        appAssembly.navigationController.pushViewController(initialViewController, animated: false)
        
        appAssembly.window.rootViewController = appAssembly.navigationController
        
        appAssembly.window.makeKeyAndVisible()
        
        return true
    }
}


//
//  AppDelegate.swift
//  UIKitApp
//
//  Created by Anton Goncharov on 13.12.2020.
//  Copyright © 2020 Anton Goncharov. All rights reserved.
//

import UIKit
import UDF
import AppModel

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var store: Store<FormState> = Store(state: FormState(), reducer: reduce)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupRootViewController()
        return true
    }

    private func setupRootViewController() {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! ViewController
        viewController.store = store

        let navigatonController = UINavigationController()
        navigatonController.viewControllers = [viewController]

        window = UIWindow()
        window?.rootViewController = navigatonController
        window?.makeKeyAndVisible()
    }
}


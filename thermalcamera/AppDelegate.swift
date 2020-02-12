//
//  AppDelegate.swift
//  thermalcamera
//
//  Created by Ashneel  Das on 1/27/20.
//  Copyright © 2020 Ashneel  Das. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // In iOS 13+ SceneDelegate.swift handles our windows.
        if #available(*, iOS 12) {
            //Create a window that is the same size as the screen
            window = UIWindow(frame: UIScreen.main.bounds)

            if let mainWindow = window {
                let viewController = ViewController()
                mainWindow.rootViewController = viewController
                mainWindow.makeKeyAndVisible()
            }
        }

        return true
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

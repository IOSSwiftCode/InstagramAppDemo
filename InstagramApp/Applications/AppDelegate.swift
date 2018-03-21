//
//  AppDelegate.swift
//  InstagramApp
//
//  Created by son chanthem on 3/19/18.
//  Copyright © 2018 son chanthem. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        setupRootViewContrller()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
         ReachabilityCheck.shared.stopMonitoring()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
//        ReachabilityCheck.shared.stopMonitoring()
        print("applicationWillEnterForeground")
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
         ReachabilityCheck.shared.stopMonitoring()
        print("applicationDidBecomeActive")
    }
}

extension AppDelegate {
    
    private func setupRootViewContrller() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let rootVC = PosteTableViewController()
        let nav = UINavigationController(rootViewController: rootVC)
        self.window?.rootViewController = nav
        self.window?.makeKeyAndVisible()
    }
}

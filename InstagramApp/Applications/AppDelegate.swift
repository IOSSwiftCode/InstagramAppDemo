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
        
        ReachabilityCheck.shared.startMonitoring()

        let proxyNetwork = ProxyNetWrok(network: NetworkImpl())
        let translate = TranslationImpl()
        
        let viewModel = PostTableViewModel(networkLayer: proxyNetwork, translationLayer: translate)
 
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let rootVC = PosteTableViewController(viewModel: viewModel)
        let nav = UINavigationController(rootViewController: rootVC)
        
        self.window?.rootViewController = nav
        self.window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
//        ReachabilityCheck.shared.stopMonitoring()
        print("applicationWillResignActive")
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
//         ReachabilityCheck.shared.stopMonitoring()
        print("applicationDidEnterBackground")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
//        ReachabilityCheck.shared.stopMonitoring()
        print("applicationWillEnterForeground")
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
//         ReachabilityCheck.shared.startMonitoring()
        print("applicationDidBecomeActive")
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        ReachabilityCheck.shared.stopMonitoring()
        print("applicationWillTerminate")
    }
}


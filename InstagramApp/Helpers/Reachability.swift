//
//  Reachability.swift
//  InstagramApp
//
//  Created by son chanthem on 3/21/18.
//  Copyright © 2018 son chanthem. All rights reserved.
//

import UIKit
import Reachability
import RxSwift

class ReachabilityCheck: NSObject {
    
    static let shared = ReachabilityCheck()
    
    var isInternetAvailable: Observable<Bool> {
        return internetStatus.asObservable()
    }
    
    private let internetStatus = PublishSubject<Bool>()
    
    private var isNetworkAvailable: Bool {
        return reachabilityStatus != .none
    }
    
    private var reachabilityStatus: Reachability.Connection = .none
    
    private let reachability = Reachability()!
    
    @objc func reachabilityChanged(notification: Notification) {
        
        let reachability = notification.object as! Reachability
        
        // Check existing object
        switch reachability.connection {
            
        case .wifi:
            reachabilityStatus = .wifi
            internetStatus.onNext(isNetworkAvailable)
            debugPrint("Internet Connection via wifi ", isNetworkAvailable)
            
        case .cellular:
            reachabilityStatus = .cellular
            internetStatus.onNext(isNetworkAvailable)
            debugPrint("Internet Connection cellular", isNetworkAvailable)
            
        case .none:
            reachabilityStatus = .none
            internetStatus.onNext(isNetworkAvailable)
            print("Internet Connection", isNetworkAvailable)
        }
    }
    
    //TODO: Start Monitoring wifi
    func startMonitoring() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.reachabilityChanged),
                                               name: Notification.Name.reachabilityChanged, object: reachability)
        do {
            
            try reachability.startNotifier()
            
        } catch {
            
            print("Could not start reachability notifier")
        }
    }
    
    //TODO: Stop Monitoring wifi
    func stopMonitoring() {
        
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: Notification.Name.reachabilityChanged, object: reachability)
    }
}

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
    
    private let internetStatus = PublishSubject<Bool>()
    
    private var reachabilityStatus: Reachability.Connection = .none
    
    private let reachability = Reachability()!
    
    var isInternetAvailable: Observable<Bool> {
        return internetStatus.asObservable()
    }
    
    var isConnectionAvailable: Bool {
        return reachabilityStatus != .none
    }

    //MARK: CHECK REACHABILITY
    @objc func reachabilityChanged(notification: Notification) {
        
        let reachability = notification.object as! Reachability
        
        switch reachability.connection {
            
        case .wifi:
            reachabilityStatus = .wifi
            internetStatus.onNext(isConnectionAvailable)
            
        case .cellular:
            reachabilityStatus = .cellular
            internetStatus.onNext(isConnectionAvailable)
            
        case .none:
            reachabilityStatus = .none
            internetStatus.onNext(isConnectionAvailable)
        }
    }
    
    //MARK: Start Monitoring connection
    func startMonitoring() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.reachabilityChanged),
                                               name: Notification.Name.reachabilityChanged, object: reachability)
        do {
            
            try reachability.startNotifier()
            
        } catch {
            
            print("Could not start reachability notifier")
        }
    }
    
    //MARK: Stop Monitoring connection
    func stopMonitoring() {
        
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: Notification.Name.reachabilityChanged, object: reachability)
    }
}

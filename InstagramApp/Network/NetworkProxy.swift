//
//  NetworkProxy.swift
//  InstagramApp
//
//  Created by chanthem on 3/23/18.
//  Copyright © 2018 son chanthem. All rights reserved.
//

import Foundation
import RxSwift


class NetwrokProxy: NSObject, Network {
    
    private var network : Network!
    
    private let disposeBag = DisposeBag()
    
    init(network: Network) {
        super.init()
        
        self.network = network
    }
    
    //MARK: IMPLEMENT METHOD FROM CONFIRMED PROTOCOL
    func requestData(url: String, param: [String : Any]?, completed: @escaping completedHandler) {
        
        if ReachabilityCheck.shared.isConnectionAvailable {
            network.requestData(url: url, param: param, completed: { (data) in
                completed(data)
            })
        } else {
            completed(nil)
        }
    }
    
    //MARK: IMPLEMENT METHOD FROM CONFIRMED PROTOCOL
    func listPostPagiation(url: String, completed: @escaping completedHandler) {
        if ReachabilityCheck.shared.isConnectionAvailable {
            network.listPostPagiation(url: url, completed: { (data) in
                completed(data)
            })
        } else {
            completed(nil)
        }
    }
}

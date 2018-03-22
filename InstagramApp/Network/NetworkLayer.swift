//
//  NetworkLayer.swift
//  InstagramApp
//
//  Created by chanthem on 3/20/18.
//  Copyright © 2018 son chanthem. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

typealias completedHandler = (Data?) -> Void

protocol Network {
    
    func requestData(url: String, param: [String: Any]?, completed: @escaping completedHandler)
    func listPostPagiation(url: String, completed: @escaping completedHandler)
}

class NetworkImpl: Network {
    
    private let header: HTTPHeaders = ["Accept": "application/json"]
    
    func requestData(url: String, param: [String : Any]?, completed: @escaping completedHandler) {
        listPostsFromServer(url: url, param: param) { (data) in
            completed(data)
        }
    }
    
    func listPostPagiation(url: String, completed: @escaping completedHandler) {
        listPostsFromServer(url: url, param: nil) { (data) in
            completed(data)
        }
    }
    
    private func listPostsFromServer(url: String, param: [String: Any]?, completed: @escaping (Data?) -> Void) {
        
        let paramater: Parameters? = param
        
        Alamofire.request(url, method: .get, parameters: paramater, encoding: URLEncoding.queryString, headers: header).responseJSON { response in
            
            print(response.data as Any)
            
            guard let data = response.data else { return }
            
            completed(data)
        }
    }
}

class ProxyNetWrok: NSObject, Network {
    
    private var network : Network!
    
    private let disposeBag = DisposeBag()

    init(network: Network) {
        super.init()
        
        self.network = network
    }
    
    func requestData(url: String, param: [String : Any]?, completed: @escaping completedHandler) {
        
        if ReachabilityCheck.shared.isConnectionAvailable {
            network.requestData(url: url, param: param, completed: { (data) in
                completed(data)
            })
        } else {
            completed(nil)
        }
    }
    
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




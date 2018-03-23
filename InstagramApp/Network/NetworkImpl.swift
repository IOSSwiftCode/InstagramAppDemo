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

class NetworkImpl {
    
    private let header: HTTPHeaders = ["Accept": "application/json"]
    
    //MARK: REQUEST DATA FROM SERVER
    private func listPostsFromServer(url: String, param: [String: Any]?, completed: @escaping (Data?) -> Void) {
        
        let paramater: Parameters? = param
        
        Alamofire.request(url, method: .get, parameters: paramater, encoding: URLEncoding.queryString, headers: header).responseJSON { response in
            
            print(response.data as Any)
            
            guard let data = response.data else { return }
            
            completed(data)
        }
    }
}

//MARK: COMFIRM NETWORK PROTOCOL AND IMPLEMENT METHOD
extension NetworkImpl: Network {
    
    //MARK: CALLED REQUEST DATA WITHIN PARAMETER
    func requestData(url: String, param: [String : Any]?, completed: @escaping completedHandler) {
        listPostsFromServer(url: url, param: param) { (data) in
            completed(data)
        }
    }
    
    //MARK: CALLED REQUEST DATA FOR PAGINATION
    func listPostPagiation(url: String, completed: @escaping completedHandler) {
        listPostsFromServer(url: url, param: nil) { (data) in
            completed(data)
        }
    }
    
}




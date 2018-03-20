//
//  NetworkLayer.swift
//  InstagramApp
//
//  Created by chanthem on 3/20/18.
//  Copyright © 2018 son chanthem. All rights reserved.
//

import Foundation
import Alamofire

protocol Network {
    func listPostsFromServer(url: String, param: [String: Any], completed: @escaping (Data) -> Void)
}

class NetworkImpl: Network {
    
    let header: HTTPHeaders = ["Accept": "application/json"]
    
    func listPostsFromServer(url: String, param: [String: Any], completed: @escaping (Data) -> Void) {
        
        let paramater: Parameters = param
        
        Alamofire.request(url, method: .get, parameters: paramater, encoding: URLEncoding.queryString, headers: header).responseJSON { response in
            
            print(response.data as Any)
            
            guard let data = response.data else { return }
            
            completed(data)
        }
    }
}


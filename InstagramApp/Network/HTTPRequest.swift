//
//  HTTPRequest.swift
//  InstagramApp
//
//  Created by chanthem on 3/24/18.
//  Copyright © 2018 son chanthem. All rights reserved.
//

import Foundation
import Alamofire

//MARK: HTTP HEADER USE FOR REQUEST
struct RequestHeader {
    private static let authorization = "Authorization"
    private static let contentType = "Content-Type"
    private static let accept = "Accept"

    static let header: HTTPHeaders = ["\(RequestHeader.authorization)": "application/json"]
}

//MARK: HTTP PARAMETER USE FOR REQUEST
struct RequestParameter {
    private static let accessToken = "access_token"
    private static let count = "count"
    
    static let param: [String : Any] = ["\(RequestParameter.accessToken)" : AccessToken.token, "\(RequestParameter.count)" : 3]
}

//MARK: ACCESS TOKEN VALUE
struct AccessToken {
    static let token = "2305280051.c61562d.173fac7d5397411ab13207bf5abda620"
}

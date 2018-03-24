//
//  BaseURLConfigure.swift
//  InstagramApp
//
//  Created by chanthem on 3/20/18.
//  Copyright © 2018 son chanthem. All rights reserved.
//

import Foundation

fileprivate protocol BaseURLConfig {
    static var baseURL: String { get }
}

//MARK: PRODUCTION BASE URL
fileprivate struct ProductionURL: BaseURLConfig  {
    static var baseURL: String {
        return "https://api.instagram.com/v1/users/self/media/recent/"
    }
    
    
}

//MARK: CONFIGURE URL TYPE
fileprivate struct BaseURLConfiguration<T:BaseURLConfig> {
    
    static var url: String {
        return T.baseURL
    }
}

fileprivate protocol BaseURLActive {
    static var active: String! { get set }
}

//MARK: CONFIGURE BASE URL ACTIVE
struct BaseURL: BaseURLActive {
    fileprivate typealias baseURL = BaseURL
    fileprivate static var active: String! = BaseURLConfiguration<ProductionURL>.url
}

//MARK: BASE URL FOR GET POSTS
extension BaseURL {
    public enum Post: String {
        
        case getData
        
        var url: String {
            switch self {
            case .getData:
                return baseURL.active
            }
        }
    }
}


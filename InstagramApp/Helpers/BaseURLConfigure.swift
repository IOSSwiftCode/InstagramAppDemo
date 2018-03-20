//
//  BaseURLConfigure.swift
//  InstagramApp
//
//  Created by chanthem on 3/20/18.
//  Copyright © 2018 son chanthem. All rights reserved.
//

import Foundation

fileprivate protocol BaseURLConfigurationType {
    static var baseURL : String { get }
}

fileprivate struct BaseURLProduction: BaseURLConfigurationType  {
    static var baseURL: String {
        return "https://api.instagram.com/v1/users/self/media/recent/"
    }
}

fileprivate struct BaseURLConfigurationFactory<T:BaseURLConfigurationType> {
    
    private static var currentURL: String {
        return T.baseURL
    }
    
    static var active: String {
        return currentURL
    }
}

fileprivate protocol BaseURLConfigurationActiveType {
    static var active: String! { get set }
}

struct BaseURL: BaseURLConfigurationActiveType {
    fileprivate typealias me = BaseURL
    fileprivate static var active: String! = BaseURLConfigurationFactory<BaseURLProduction>.active
}

// Post NewsFeed URL
extension BaseURL {
    public enum Post: String {
        
        case getData
        
        var value: String {
            switch self {
            case .getData:
                return me.active
            }
        }
    }
}


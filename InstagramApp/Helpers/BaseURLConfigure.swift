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

//MARK: PRODUCTION BASE URL
fileprivate struct BaseURLProduction: BaseURLConfigurationType  {
    static var baseURL: String {
        return "https://api.instagram.com/v1/users/self/media/recent/"
    }
}

//MARK: CONFIGURE URL TYPE
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

//MARK: CONFIGURE BASE URL ACTIVE
struct BaseURL: BaseURLConfigurationActiveType {
    fileprivate typealias me = BaseURL
    fileprivate static var active: String! = BaseURLConfigurationFactory<BaseURLProduction>.active
}

//MARK: BASE URL FOR GET POSTS
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


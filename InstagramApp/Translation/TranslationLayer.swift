//
//  TranslationLayer.swift
//  InstagramApp
//
//  Created by chanthem on 3/20/18.
//  Copyright © 2018 son chanthem. All rights reserved.
//

import Foundation
import ObjectMapper

protocol Translation {
    func traslateJsonDataToPosts<T: Mappable>(_ data: Data) -> T?
}

class TranslationImpl: Translation {
    
    typealias dictionary = [String : Any]
    
    func traslateJsonDataToPosts<T: Mappable>(_ data: Data) -> T? {
        
        guard let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) else {
            return  nil
        }
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                let posts = T(JSONString: jsonString)
                return posts
            }
        }
        
        return nil
    }
}

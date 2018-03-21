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
    func traslateJsonDataToPosts(_ data: Data) -> ListPosts
}

class TranslationImpl: Translation {
    
    typealias dictionary = [String : Any]
    
    func traslateJsonDataToPosts(_ data: Data) -> ListPosts {
        
        var listPosts = ListPosts()
        
        guard let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) else { return  listPosts }
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                let posts = ListPosts(JSONString: jsonString)
                listPosts = posts!
            }
        }
        
        return listPosts
    }
}

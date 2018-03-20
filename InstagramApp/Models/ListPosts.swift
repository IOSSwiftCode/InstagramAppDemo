//
//  ListPosts.swift
//  InstagramApp
//
//  Created by chanthem on 3/20/18.
//  Copyright © 2018 son chanthem. All rights reserved.
//

import Foundation
import ObjectMapper

struct ListPosts: Mappable {
    
    var data: [Post]?
    var pagination: Pagination?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        data        <- map["data"]
        pagination  <- map["pagination"]
    }
    
}

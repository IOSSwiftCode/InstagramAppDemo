//
//  Pagination.swift
//  InstagramApp
//
//  Created by chanthem on 3/20/18.
//  Copyright © 2018 son chanthem. All rights reserved.
//

import Foundation
import ObjectMapper

struct Pagination: Mappable {
    
    var nextMaxId: String?
    var nextURL: String?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        nextMaxId    <- map["next_max_id"]
        nextURL      <- map["next_url"]
    }
}

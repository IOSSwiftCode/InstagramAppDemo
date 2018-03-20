//
//  Like.swift
//  InstagramApp
//
//  Created by chanthem on 3/20/18.
//  Copyright © 2018 son chanthem. All rights reserved.
//

import Foundation
import ObjectMapper

struct Like: Mappable {
    
    var count : Int?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        count    <- map["count"]
    }
}

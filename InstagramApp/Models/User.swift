//
//  User.swift
//  InstagramApp
//
//  Created by chanthem on 3/20/18.
//  Copyright © 2018 son chanthem. All rights reserved.
//

import Foundation
import ObjectMapper

struct User: Mappable {
    
    var profileImage : String?
    var username: String?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        profileImage    <- map["profile_picture"]
        username        <- map["username"]
    }
    
}

//
//  PostImage.swift
//  InstagramApp
//
//  Created by chanthem on 3/20/18.
//  Copyright © 2018 son chanthem. All rights reserved.
//

import Foundation
import ObjectMapper

struct PostImage: Mappable {
    
    var imageWidth: Int?
    var imageHeight: Int?
    var imageURL: String?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        imageWidth      <- map["width"]
        imageHeight     <- map["height"]
        imageURL        <- map["url"]
    }
}

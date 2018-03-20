//
//  NewsFeed.swift
//  InstagramApp
//
//  Created by chanthem on 3/20/18.
//  Copyright © 2018 son chanthem. All rights reserved.
//

import Foundation
import ObjectMapper

struct Post: Mappable {
    
    var user: User?
    var postImgae: PostImage?
    var like: Like?
    var desc: String?
    var comment: Comment?
    var createdTime: String?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        user           <- map["user"]
        postImgae      <- map["images"]["low_resolution"]
        desc           <- map["caption"]
        like           <- map["likes"]
        comment        <- map["comments"]
        createdTime    <- map["created_time"]
    }
}

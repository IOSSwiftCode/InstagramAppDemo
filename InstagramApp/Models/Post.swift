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
    
    var id : String?
    var user: User?
    var postImgae: PostImage?
    var like: Like?
    var desc: String?
    var comment: Comment?
    var createdTime: Date?
    
    init?(map: Map) {}
    
    init() {}
    
    mutating func mapping(map: Map) {
        id             <- map["id"]
        user           <- map["user"]
        postImgae      <- map["images.low_resolution"]
        desc           <- map["caption"]
        like           <- map["likes"]
        comment        <- map["comments"]
        createdTime    <- (map["created_time"], DateTransform())
    }
}

extension Post: Equatable{
    
    static func ==(lhs: Post, rhs: Post) -> Bool {
        return lhs.id == rhs.id
    }
}

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
        
        guard let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as! dictionary else { return  listPosts }
        
        if let pagination = json["pagination"] as? dictionary {
            listPosts.pagination = Pagination(JSON: pagination)
        }
        
        if let posts = json["data"] as? NSArray {
            posts.forEach { post in
                
//                let newPost = post as! dictionary
//                let user = User(JSON: newPost["user"] as! dictionary)
//                let comment = Comment(JSON: newPost["comments"] as! dictionary)
//                let like = Like(JSON: newPost["likes"] as! dictionary)
//
                listPosts.data?.append(Post(JSONString: post as! String)!)
            }
        
        }
        
        return listPosts
    }
}

//
//  PostTableVieeCellViewModel.swift
//  InstagramApp
//
//  Created by chanthem on 3/22/18.
//  Copyright © 2018 son chanthem. All rights reserved.
//

import Foundation

class PostCellViewModel {
    
    private let post: Post
    
    init(post: Post) {
        self.post = post
    }
    
    var profileImage: URL {
        return URL(string: post.user!.profileImage!)!
    }
    
    var postImgae: URL {
        return URL(string: post.postImgae!.imageURL!)!
    }
    
    var username: String {
        return post.user!.username!
    }
    
    var like: String {
        return likeCount(like: post.like!.count!)
    }
    
    var comment: String {
        return commentCount(comment: post.comment!.count!)
    }
    
    var duration: String {
        return stringFromDate(date: post.createdTime!)
    }
}

extension PostCellViewModel {
    
    //MARK: RETURN NUMBER LIKES AS STRING
    private func likeCount(like: Int) -> String {
        return like > 0 ? "\(like) Likes" : "\(like) Like"
    }
    
    //MARK: RETURN NUMBER COMMENT AS STRING
    private func commentCount(comment: Int) -> String {
        return comment > 0 ? "\(comment) Comments" : "\(comment) Comment"
    }
    
    //MARK: RETURN POSTED PEROID AS STRING
    private func stringFromDate(date: Date) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        let dateString = dateFormatter.string(from: date)
        guard let date = dateFormatter.date(from: dateString) else {
            fatalError("Unable to create date from string \(dateString) with format \(dateFormatter.dateFormat)")
        }
        
        let now = Date()
        
        let componentsFormatter = DateComponentsFormatter()
        componentsFormatter.allowedUnits = [.day, .minute, .hour]
        componentsFormatter.maximumUnitCount = 2
        componentsFormatter.unitsStyle = .full
        
        guard let fromString = componentsFormatter.string(from: date, to: now) else { return "" }
        
        return "\(fromString) ago".uppercased()
    }
}

//
//  PostDetailViewController.swift
//  InstagramApp
//
//  Created by chanthem on 3/21/18.
//  Copyright © 2018 son chanthem. All rights reserved.
//

import Foundation
import RxSwift

class PostDetailViewModel: NSObject {
    
    private var post: Observable<[Post]>
    
    lazy var getPost : Observable<[Post]> = {
        return post
    }()
    
    init(post: Post) {
        self.post = Observable.of([post])
        super.init()
    }
    
}

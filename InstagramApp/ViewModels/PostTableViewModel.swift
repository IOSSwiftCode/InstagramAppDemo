//
//  PostTableViewModel.swift
//  InstagramApp
//
//  Created by chanthem on 3/20/18.
//  Copyright © 2018 son chanthem. All rights reserved.
//

import Foundation
import RxSwift

class PostTableViewModel: NSObject {
    
    private var listPosts : ListPosts?
    private var networkLayer: Network?
    private var translationLayer: Translation?
    
    let posts = Variable<[Post]>([])
    var pagination = Variable<Pagination?>(nil)
    
    init(networkLayer: Network, translationLayer: Translation) {
        super.init()
        
        self.networkLayer = networkLayer
        self.translationLayer = translationLayer
        
        DispatchQueue.global(qos: .userInitiated).async {
            self.listAllPosts()
        }
    }
}

extension PostTableViewModel {
    
    private func listAllPosts(){

        let url = BaseURL.Post.getData.value
        let param = ["access_token" : "2305280051.c61562d.173fac7d5397411ab13207bf5abda620",
                     "count" : 8] as [String : Any]
        
        networkLayer?.listPostsFromServer(url: url, param: param, completed: { [weak self] (data) in
            
            self?.listPosts = self?.translationLayer?.traslateJsonDataToPosts(data)
            
            self?.posts.value = (self?.listPosts?.data)!
            self?.pagination.value = (self?.listPosts?.pagination)!
        })
    }
    
    func selectedRow(index: Int) -> Post {
        
        return posts.value[index]
    }
    
    func pullToRefresh() {
        listAllPosts()
    }
}

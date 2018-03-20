//
//  PostTableViewModel.swift
//  InstagramApp
//
//  Created by chanthem on 3/20/18.
//  Copyright © 2018 son chanthem. All rights reserved.
//

import Foundation

protocol TableViewModel {
    
}

class PostTableViewModel: NSObject, TableViewModel {
    
    fileprivate var listPosts : ListPosts?
    fileprivate var networkLayer: Network?
    fileprivate var translationLayer: Translation?
    
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
    
    private func listAllPosts() {
        
        let url = BaseURL.Post.getData.value
        let param = ["access_token" : "2305280051.c61562d.173fac7d5397411ab13207bf5abda620",
                     "count" : 2] as [String : Any]
        
        networkLayer?.listPostsFromServer(url: url, param: param, completed: { [weak self] (data) in
            self?.listPosts = self?.translationLayer?.traslateJsonDataToPosts(data)
            print(self?.listPosts!.data![0].user!.username ?? "")
        })
    }
    
    
    
}

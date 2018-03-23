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

    private var networkLayer: Network?
    private var translationLayer: Translation?
    private let disposeBag = DisposeBag()
    
    let posts = Variable<[Post]>([])
    var pagination = Variable<Pagination?>(nil)
    
    init(networkLayer: Network, translationLayer: Translation) {
        
        super.init()
        
        self.networkLayer = networkLayer
        self.translationLayer = translationLayer
        
        //MARK: SUBSCRIBE TO REACHABILITY
        ReachabilityCheck.shared.isInternetAvailable.subscribe(onNext: { [weak self] (status) in
            guard status else {
                return
            }
            self?.listAllPosts()
            
        }).disposed(by: disposeBag)
    }
}

extension PostTableViewModel {
    
    //MARK: GET LIST POSTS
    private func listAllPosts() {

        let url = BaseURL.Post.getData.value
        let param = ["access_token" : "2305280051.c61562d.173fac7d5397411ab13207bf5abda620",
                     "count" : 3] as [String : Any]
        
        networkLayer?.requestData(url: url, param: param, completed: { [weak self] (data) in
            
            guard let data = data else {
                return
            }
            
            guard let listPosts = self?.translationLayer?.traslateJsonDataToPosts(data) else {
                return
            }
            self?.posts.value = listPosts.data!
            self?.pagination.value = listPosts.pagination
        })
    }
    
    //MARK: GET MORE POSTS PAGINATION
    func listPostsWithPagination() {
        
        guard let url = pagination.value?.nextURL else {
            self.pagination.value = nil
            return
        }
        
        networkLayer?.listPostPagiation(url: url, completed: { [weak self] (data) in
            guard let data = data else {
                return
            }
            
            guard let listPosts = self?.translationLayer?.traslateJsonDataToPosts(data) else {
                return
            }

            self?.posts.value.append(contentsOf: listPosts.data!)
            self?.pagination.value = listPosts.pagination
        })
    }
    
    //MARK: DID SELECTED ROW
    func selectedRow(index: Int) -> Post {
        
        return posts.value[index]
    }
    
    //MARK: PULL TO REFRESH
    func pullToRefresh() {
        listAllPosts()
    }
}

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
    private let queue = DispatchQueue(label: "QueueFetchData")
    
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

        let url = BaseURL.Post.getData.url
        
        networkLayer?.requestData(url: url, param:RequestParameter.param, completed: { [weak self] (data) in
            
            guard let data = data else {
                return
            }
            
            guard let listPosts: ListPosts = self?.translationLayer?.traslateJsonDataToPosts(data) else {
                return
            }
            
            self?.posts.value = listPosts.data!
            self?.pagination.value = listPosts.pagination
        })
    }
    
    //MARK: GET MORE POSTS PAGINATION
    func listPostsWithPagination() {
        
        queue.sync {
            self.fetchPosts()
        }
    }
    
    fileprivate func fetchPosts() {
        guard let url = pagination.value?.nextURL else {
            self.pagination.value = nil
            return
        }
        
        networkLayer?.requestData(url: url, param: nil, completed: { [weak self] (data) in
            guard let data = data else {
                return
            }
            
            guard let listPosts: ListPosts = self?.translationLayer?.traslateJsonDataToPosts(data) else {
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

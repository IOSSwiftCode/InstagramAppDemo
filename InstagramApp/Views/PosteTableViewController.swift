//
//  MainViewController.swift
//  InstagramApp
//
//  Created by son chanthem on 3/19/18.
//  Copyright © 2018 son chanthem. All rights reserved.
//

import UIKit

class PosteTableViewController: UITableViewController {
    
    private var viewModel: TableViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        addNavigationItems()
        
        viewModel = PostTableViewModel(networkLayer: NetworkImpl(), translationLayer: TranslationImpl())
        
    }
    
}

//MARK: ADD NAVIGATION ITEM
extension PosteTableViewController {
    
    private func addNavigationItems() {
        
        self.navigationController?.navigationBar.topItem?.title = "Instagram"
        
        let leftItem = UIBarButtonItem(image: UIImage(named: "camera"), style: .plain, target: self, action: nil)
        leftItem.tintColor = .black
        
        let rightItem = UIBarButtonItem(image: UIImage(named: "sent"), style: .plain, target: self, action: nil)
        rightItem.tintColor = .black
        
        self.navigationItem.leftBarButtonItem = leftItem
        self.navigationItem.rightBarButtonItem = rightItem
    }
}

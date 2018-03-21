//
//  MainViewController.swift
//  InstagramApp
//
//  Created by son chanthem on 3/19/18.
//  Copyright © 2018 son chanthem. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PosteTableViewController: UIViewController {
    
    private var viewModel: PostTableViewModel!
    private var tableView: UITableView!
    
    private let refreshControl = UIRefreshControl()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        
        tableView = UITableView(frame: self.view.frame)
        
        self.view.addSubview(tableView)
        
        addNavigationItems()
        
        viewModel = PostTableViewModel(networkLayer: NetworkImpl(), translationLayer: TranslationImpl())
        
        
        configureTableView()
        bindDataToTableView()
        tableViewCellDidSelected()
    }
}

extension PosteTableViewController {
    
    private func configureTableView() {
        
        PostTableViewCell.register(with: tableView)
        tableView.separatorStyle = .none
        tableView.rowHeight = 480
        
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
    }
    
    private func bindDataToTableView() {
        viewModel.posts.asObservable()
        .bind(to: tableView.rx.items(cellIdentifier: PostTableViewCell.cellId, cellType: PostTableViewCell.self)) {
            row, element, cell in
            
            cell.configure(with: element)
            
        }.disposed(by: disposeBag)
    }
    
    private func tableViewCellDidSelected() {
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                let post = self?.viewModel.selectedRow(index: indexPath.row)
                let detailVC = DetailViewController()
                detailVC.viewModel = PostDetailViewModel(post: post!)
                self?.navigationController?.pushViewController(detailVC, animated: true)
            }).disposed(by: disposeBag)
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



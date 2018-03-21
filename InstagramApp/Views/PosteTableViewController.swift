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
    private var loadingIndicator : LoadingIndicatorView!
    
    private let disposeBag = DisposeBag()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        
        viewModel = PostTableViewModel(networkLayer: NetworkImpl(), translationLayer: TranslationImpl())

        addNavigationItems()
        createIndicatorLoading()
        configureTableView()
        bindDataToTableView()
        tableViewCellDidSelected()
    }
}

extension PosteTableViewController {
    
    private func configureTableView() {
        
        tableView = UITableView(frame: self.view.frame)
        self.view.addSubview(tableView)
        
        PostTableViewCell.register(with: tableView)
        tableView.separatorStyle = .none
        tableView.rowHeight = 480
        
        // Add Refresh Control to Table View
        tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
    }
    
    private func bindDataToTableView() {
        viewModel.posts.asObservable()
        .filter { [weak self] post in
            if post.count > 0 {
                self?.loadingIndicator.stopIndicatorLoading()
            }
            return true
        }
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
    
    @objc private func pullToRefresh() {
        viewModel.pullToRefresh()
        refreshControl.endRefreshing()
    }
    
    private func createIndicatorLoading() {
        
        loadingIndicator = LoadingIndicatorView(frame: view.frame)
        
        view.addSubview(loadingIndicator)
        
        loadingIndicator.startIndicatorLoading()
    }
}



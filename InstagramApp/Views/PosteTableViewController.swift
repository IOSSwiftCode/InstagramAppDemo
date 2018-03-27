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
    
    private let viewModel: PostTableViewModel
    private var tableView: UITableView!

    private var isConnecting: Bool!
    private var loadingIndicator : UIActivityIndicatorView!
    
    private let disposeBag = DisposeBag()
    private lazy var refreshControl = UIRefreshControl()
  
    
    init(viewModel: PostTableViewModel) {
        
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        
        addNavigationItems()
        configureTableView()
        createIndicatorLoading()
        bindDataToTableView()
      
    }

}

extension PosteTableViewController {
    
    //MARK: CONFIGURE TABLE VIEW
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
    
    //MARK: BIND DATA TO TABLE VIEW
    private func bindDataToTableView() {
        
        //MARK: BINDING DATA
        viewModel.posts.asDriver()
        .filter({ post in

            return post.count > 0
        })
        .do(onNext: { [weak self] post in
            self?.loadingIndicator.stopAnimating()
            self?.refreshControl.endRefreshing()
        })
        .drive(tableView.rx.items(cellIdentifier: PostTableViewCell.cellId, cellType: PostTableViewCell.self)) {
            row, element, cell in
            
            cell.configure(with: element)
            
        }.disposed(by: disposeBag)
      
        
        //MARK: SUBSCRIPT TO TABLEVIEW ITEMSELECTED FTO SHOW DETAIL
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                let post = self?.viewModel.selectedRow(index: indexPath.row)
                let detailVC = DetailViewController()
                detailVC.viewModel = PostDetailViewModel(post: post!)
                self?.navigationController?.pushViewController(detailVC, animated: true)
            }).disposed(by: disposeBag)
        
        
        //MARK: SUBSCRIPT TO TABLEVIEW SCROLL FOR GET MORE PAGINATION
        tableView.rx.didEndDragging
        .debounce(0.5, scheduler: MainScheduler.instance)
        .withLatestFrom(self.tableView.rx.contentOffset)
        
        .filter { [weak self] _ in
            return (self?.tableView.isNearBottomEdge(edgeOffset: 40))!
        }
        .do(onNext: { [weak self] _ in
          if ReachabilityCheck.shared.isConnectionAvailable {
            self?.addLoadingToTableFooter()
          }
        })
        .subscribe { [weak self] _ in
            print("didEndDragging")
            self?.viewModel.listPostsWithPagination()
        }.disposed(by: disposeBag)
        
        
        //MARK: SUBSCRIPT TO PAGINATION FOR ANY UPDATE
        viewModel.pagination.asObservable()
        .skip(1)
        .skipWhile({ (page) in
            return page == nil
        })
        .filter {  (page) in
            return page?.nextURL == nil
        }
        .do(onNext: { [weak self] _ in
            self?.loadingIndicator.stopAnimating()
            print("pagination")
        }).subscribe().disposed(by: disposeBag)
        
        //MARK: SUBSCRIPT DEVICE ORIENTATION EVENT
        self.rx.sentMessage(#selector(self.viewWillTransition(to:with:)))
            .map({ (params) in
                return params[0] as! CGSize
            })
            .subscribe(onNext: { [weak self] (size) in
                self?.tableView.frame.size = size
            }).disposed(by: disposeBag)
    }
}

//MARK: ADD SOME SUBVIEW TO VIEW CONTROLLER
extension PosteTableViewController {
    
    //MARK: ADD NAVIGATION ITEMS
    private func addNavigationItems() {
        
        self.navigationController?.navigationBar.topItem?.title = "Instagram"
        
        let leftItem = UIBarButtonItem(image: UIImage(named: "camera"), style: .plain, target: self, action: nil)
        leftItem.tintColor = .black
        
        let rightItem = UIBarButtonItem(image: UIImage(named: "sent"), style: .plain, target: self, action: nil)
        rightItem.tintColor = .black
        
        self.navigationItem.leftBarButtonItem = leftItem
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
    //MARK: PULL TO REFRESH
    @objc private func pullToRefresh() {
        viewModel.pullToRefresh()
    }
    
    //MARK: ADD LOADING INDICATOR TO VIEW WHEN FIRST LOADING
    private func createIndicatorLoading() {
        
        loadingIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        loadingIndicator.center = self.view.center
        
        self.view.addSubview(loadingIndicator)
        
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.startAnimating()
    }
    
    //MARK: ADD LOADING INDICATOR TO TABLEVIEW FOOTER
    private func addLoadingToTableFooter() {

        loadingIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        loadingIndicator.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
        
        tableView.tableFooterView = loadingIndicator
        tableView.tableFooterView?.isHidden = false
        
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.startAnimating()
    }
   
}


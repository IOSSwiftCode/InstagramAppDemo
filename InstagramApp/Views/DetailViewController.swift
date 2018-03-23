//
//  DetailViewController.swift
//  InstagramApp
//
//  Created by son chanthem on 3/19/18.
//  Copyright © 2018 son chanthem. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class DetailViewController: UIViewController {
    
    private var tableView : UITableView!
    private let disposeBag = DisposeBag()
    private var post : Post!
    
    var viewModel : PostDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        configureTableView()
        bindDataToTableView()
    }
}

extension DetailViewController {
    
    //MARK: CONFIGURE TABLE VIEW
    private func configureTableView() {
        
        tableView = UITableView(frame: self.view.frame)
        
        self.view.addSubview(tableView)
        
        PostTableViewCell.register(with: tableView)
        tableView.separatorStyle = .none
        tableView.rowHeight = 480
    }
    
    //MARK: BIND DATA TO TABLE VIEW
    private func bindDataToTableView() {
        viewModel.getPost
            .bind(to: tableView.rx.items(cellIdentifier: PostTableViewCell.cellId, cellType: PostTableViewCell.self)) {
                row, element, cell in
                
                cell.configure(with: element)
                
            }.disposed(by: disposeBag)
    }
    
}

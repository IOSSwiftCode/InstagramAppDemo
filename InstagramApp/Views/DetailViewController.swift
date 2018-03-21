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
    let disposeBag = DisposeBag()
    var viewModel : PostDetailViewModel!
    var post : Post!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        configureTableView()
        bindDataToTableView()
    }
}

extension DetailViewController {
    
    private func configureTableView() {
        
        tableView = UITableView(frame: self.view.frame)
        
        self.view.addSubview(tableView)
        
        PostTableViewCell.register(with: tableView)
        tableView.separatorStyle = .none
        tableView.rowHeight = 480
    }
    
    private func bindDataToTableView() {
        viewModel.getPost
            .bind(to: tableView.rx.items(cellIdentifier: PostTableViewCell.cellId, cellType: PostTableViewCell.self)) {
                row, element, cell in
                
                cell.configure(with: element)
                
            }.disposed(by: disposeBag)
    }
    
}
